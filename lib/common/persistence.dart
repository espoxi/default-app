import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> _localFile(String path) async {
  final rootPath = await _localPath;
  return File('$rootPath/$path');
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

Future<void> storeRaw(String data, String path) async {
  final file = await _localFile(path);
  await file.writeAsString(data);
}

Future<String?> retrieveRaw(String path) async {
  try {
    final file = await _localFile(path);
    return await file.readAsString();
  } catch (e) {
    return null;
  }
}

Future<void> delete(String path) async {
  final file = await _localFile(path);
  await file.delete();
}

abstract class Storable {
  Map<String, dynamic> toJson();
}
