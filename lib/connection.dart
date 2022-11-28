import 'dart:convert';
import 'dart:io';
import 'package:espoxiapp/config.dart';
import 'package:http/http.dart' as http;
import 'package:espoxiapp/data/wifi.dart';

class Connection {
  static final Connection _singleton = Connection._internal();

  factory Connection() {
    return _singleton;
  }

  Connection._internal();

  InternetAddress? _address;
  Future<InternetAddress?> connectEspoxiToWifi(Credentials creds) async {
    if (_address != null) {
      return _address!;
    }
    await http.post(Uri.parse('${DEFAULTURL}connect'), body: creds.toJson());
    for (int i = 0; i < 10; i++) {
      try {
        var res = await http.get(Uri.parse('${DEFAULTURL}ip'));
        if (res.statusCode == 200) {
          _address = InternetAddress(jsonDecode(res.body));
          return _address!;
        }
      } catch (e) {}
      await Future.delayed(const Duration(seconds: 1));
    }
    return null;
  }
}
