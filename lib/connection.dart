import 'dart:convert';
import 'dart:io';
import 'package:espoxiapp/config.dart';
import 'package:http/http.dart' as http;
import 'package:espoxiapp/data/wifi.dart';

import 'common/persistence.dart';
import 'effects/effect.dart';
import 'pages/setup.dart';

class Connection {
  static final Connection _singleton = Connection._internal();

  factory Connection() {
    return _singleton;
  }

  Connection._internal();

  Future init() async {
    var value = await retrieveRaw(ADDRESSPATH);
    if (value != null) {
      _address = InternetAddress(value);
    }
  }

  Future<InternetAddress?> get saverAddress async {
    if (_address == null) {
      await init();
    }
    return _address;
  }

  InternetAddress? _address;
  InternetAddress? get address => _address;
  void set address(InternetAddress? address) {
    _address = address;
    if (address != null) {
      storeRaw(address.address.toString(), ADDRESSPATH);
    } else {
      delete(ADDRESSPATH);
    }
  }

  Future<List<EffectConfig>> getEffects() async {
    final response = await http
        .get(Uri.http((await saverAddress)!.address.toString(), '/effects'));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => EffectConfig.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load effects');
    }
  }

  Future<void> setEffects(List<EffectConfig> effects) async {
    final response = await http.post(
        Uri.http((await saverAddress)!.address.toString(), '/effects'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(effects));
    if (response.statusCode != 200) {
      throw Exception('Failed to set effects');
    }
  }

  Future<InternetAddress?> connectEspoxiToWifi(Credentials creds) async {
    if (_address != null) {}
    http.post(
      Uri.parse('${DEFAULTURL}connect'),
      body: jsonEncode(creds.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    http.post(
      Uri.parse('${(await saverAddress)!.address}connect'),
      body: jsonEncode(creds.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    for (int i = 0; i < 10; i++) {
      try {
        var res = await http.get(Uri.parse('${DEFAULTURL}ip')).timeout(
            Duration(seconds: 2),
            onTimeout: () => throw Exception('Timeout'));
        if (res.statusCode == 200) {
          _address = InternetAddress(jsonDecode(res.body));
          return _address!;
        } else {
          var res = await http
              .get(Uri.parse('${(await saverAddress)!.address}ip'))
              .timeout(Duration(seconds: 2),
                  onTimeout: () => throw Exception('Timeout'));
          if (res.statusCode == 200) {
            _address = InternetAddress(jsonDecode(res.body));
            return _address!;
          }
        }
      } catch (e) {}
    }
    return null;
  }
}
