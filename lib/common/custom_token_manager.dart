import 'package:universal_html/html.dart' as html;

class CustomTokenManager {
  static const String _tokenKey = 'auth_token';
  static const String _kakaoKey = 'flutter.com.kakao.token.OAuthToken';

  static Future<void> saveToken(String token) async {
    html.window.localStorage[_tokenKey] = token;
  }

  static Future<String?> getToken() async {
    return html.window.localStorage[_tokenKey] ?? '';
  }

  static Future<void> removeToken() async {
    html.window.localStorage.remove(_tokenKey);
  }

  static Future<String?> getKaKaoToken() async {
    return html.window.localStorage[_kakaoKey] ?? '';
  }
}
