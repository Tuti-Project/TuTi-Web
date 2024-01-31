import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageManager {
  static const String _tokenKey = 'auth_token';

  static Future<String?> getStorage() async {
    return await const FlutterSecureStorage().read(key: _tokenKey);
  }

  static Future<void> saveStorage(String value) async {
    await const FlutterSecureStorage().write(key: _tokenKey, value: value);
  }

  static Future<void> removeStorage() async {
    await const FlutterSecureStorage().delete(key: _tokenKey);
  }
}
