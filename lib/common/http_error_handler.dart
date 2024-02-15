import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/common/custom_token_manager.dart';
import 'package:tuti/common/flutter_security_storage_manager.dart';
import 'package:tuti/common/tuti_snackbar.dart';

class HttpErrorHandler {
  final BuildContext context;
  final dynamic data;

  HttpErrorHandler(
    this.context,
    this.data,
  );

  Future<void> handleResponse() async {
    if (data['code'] == 401 || data['message'] == '유효하지 않은 토큰입니다.') {
      TuTiSnackBar.showSnackBar(context, '로그인이 세션이 만료되었습니다. 다시 로그인해주세요.');
      if (kIsWeb) {
        await CustomTokenManager.removeToken();
      } else {
        await FlutterSecureStorageManager.removeStorage();
      }
      if (context.mounted) {
        context.go('/home');
      }
    } else {
      // TuTiSnackBar.showSnackBar(context, data['message'].toString());
    }
  }
}
