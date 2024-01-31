import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tuti/common/custom_token_manager.dart';

class CustomInterceptor extends Interceptor {
  final Ref ref;
  final FlutterSecureStorage? storage;
  final Future<String?>? token;

  CustomInterceptor({
    required this.ref,
    this.storage,
    this.token,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // 헤더 삭제
    options.headers.remove('accessToken');

    String? accessToken = '';
    if (kIsWeb) {
      accessToken = await CustomTokenManager.getToken();
    } else {
      accessToken = await storage?.read(key: 'accessToken');
    }

    // 실제 토큰으로 대체
    options.headers.addAll({
      'authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE',
      'Access-Control-Allow-Headers':
          'Origin, X-Api-Key, X-Requested-With, Content-Type, Accept, Authorization',
    });

    super.onRequest(options, handler);
  }
}

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  if (kIsWeb) {
    final token = CustomTokenManager.getToken();
    dio.interceptors.add(
      CustomInterceptor(ref: ref, token: token),
    );
  } else {
    const storage = FlutterSecureStorage();
    dio.interceptors.add(
      CustomInterceptor(ref: ref, storage: storage),
    );
  }
  return dio;
});
