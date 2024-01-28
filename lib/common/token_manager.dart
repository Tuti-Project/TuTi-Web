import 'dart:html' as html;

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
