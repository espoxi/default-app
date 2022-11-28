import 'dart:convert';
import 'dart:io';
import 'package:espoxiapp/config.dart';
import 'package:http/http.dart' as http;
import 'package:espoxiapp/data/wifi.dart';

import 'common/persistence.dart';
import 'pages/setup.dart';

class Connection {
  static final Connection _singleton = Connection._internal();

  factory Connection() {
    return _singleton;
  }

  Connection._internal() {
    retrieveRaw(ADDRESSPATH).then((value) {
      if (value != null) {
        _address = InternetAddress(value);
      }
    });
  }

  InternetAddress? _address;
  InternetAddress? get address => _address;
  void set address(InternetAddress? address) {
    _address = address;
    storeRaw(address.toString(), ADDRESSPATH);
  }

  Future<InternetAddress?> connectEspoxiToWifi(Credentials creds) async {
    if (_address != null) {}
    http.post(
      Uri.parse('${DEFAULTURL}connect'),
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
        }
      } catch (e) {}
      await Future.delayed(const Duration(milliseconds: 200));
    }
    return null;
  }
}
