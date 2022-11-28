import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> _localFile(String path) async {
  final rpath = await _localPath;
  return File('$rpath/$path');
}

Future<T?> retrieve<T>(
    T? Function(Map<String, dynamic>) fromJson, String path) async {
  try {
    final file = await _localFile(path);
    final contents = await file.readAsString();
    return fromJson(Map<String, dynamic>.from(jsonDecode(contents)));
  } catch (e) {
    return null;
  }
}

Future<void> store<T extends Storable>(T data, String path) async {
  final file = await _localFile(path);
  await file.writeAsString(jsonEncode(data.toJson()));
}

abstract class Storable {
  Map<String, dynamic> toJson();
}
