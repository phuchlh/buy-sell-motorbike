import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SharedInstances {
  static const secureStorage = FlutterSecureStorage();

  static Future<void> secureWrite(String key, dynamic value) {
    return secureStorage.write(key: key, value: jsonEncode(value));
  }

  static Future<bool> secureWriteIfAbsent(String key, dynamic value) async {
    if (await secureStorage.containsKey(key: key)) {
      secureStorage.write(key: key, value: jsonEncode(value));
      return Future.value(true);
    }
    return Future.value(false);
  }

  static Future<String?> secureRead(String key) {
    return secureStorage.read(key: key);
  }

  static Future<bool> secureContainsKey(String key) {
    return secureStorage.containsKey(key: key);
  }

  static Future<String?> secureRemove(String key) async {
    String? value = await secureStorage.read(key: key);

    if (value != null) {
      secureStorage.delete(key: key);
      return value;
    }

    return null;
  }
}
