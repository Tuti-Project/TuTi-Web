import 'dart:html' as html;

import 'package:logger/logger.dart';

class TokenManager {
  static const String _tokenKey = 'auth_token';

  static Future<void> saveToken(String token) async {
    html.window.localStorage[_tokenKey] = token;
  }

  static Future<String?> getToken() async {
    return html.window.localStorage[_tokenKey] ?? '';
  }

  static Future<void> removeToken() async {
    html.window.localStorage.remove(_tokenKey);
  }
}

// 예제에서 사용하는 방법
void main() async {
  // 앱이 시작될 때 토큰 검색
  String? token = await TokenManager.getToken();
  Logger().i('Stored Token: $token');

  // 토큰 저장
  await TokenManager.saveToken('your_token_value');

  // 저장된 토큰 검색
  token = await TokenManager.getToken();
  Logger().i('Stored Token: $token');

  // 토큰 제거
  await TokenManager.removeToken();
}
