import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/common/flutter_security_storage_manager.dart';
import 'package:tuti/common/token_manager.dart';
import 'package:tuti/common/tuti_snackbar.dart';

class HttpErrorHandler {
  final BuildContext context;
  final dynamic data;

  HttpErrorHandler(
    this.context,
    this.data,
  );

  Future<void> handleResponse() async {
    if (data['code'] == 401) {
      TuTiSnackBar.showSnackBar(context, '로그인이 세션이 만료되었습니다. 다시 로그인해주세요.');
      if (kIsWeb) {
        await TokenManager.removeToken();
      } else {
        await FlutterSecureStorageManager.removeStorage();
      }
      if (context.mounted) {
        context.go('/login');
      }
    } else {
      TuTiSnackBar.showSnackBar(context, data['message'].toString());
    }
  }
}
