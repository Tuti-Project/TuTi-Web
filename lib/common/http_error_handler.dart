import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/common/tuti_snackbar.dart';

class HttpErrorHandler {
  final BuildContext context;
  final dynamic data;

  HttpErrorHandler(
    this.context,
    this.data,
  );

  void handleResponse() {
    if (data['code'] == 401) {
      TuTiSnackBar.showSnackBar(context, '로그인이 세션이 만료되었습니다. 다시 로그인해주세요.');
      context.go('/login');
    } else {
      TuTiSnackBar.showSnackBar(context, data['message'].toString());
    }
  }
}
