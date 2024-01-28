import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final Ref ref;
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
    required this.ref,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // 헤더 삭제
    options.headers.remove('accessToken');

    final accessToken = await storage.read(key: 'accessToken');

    // 실제 토큰으로 대체
    options.headers.addAll({
      'authorization': 'Bearer $accessToken',
      'Access-Control-Allow-Origin': '*',
    });

    super.onRequest(options, handler);
  }
}

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  const storage = FlutterSecureStorage();
  dio.interceptors.add(
    CustomInterceptor(storage: storage, ref: ref),
  );
  return dio;
});
