import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/features/auth/models/user_profile_model.dart';

class AuthService {
  final _dio = Dio();
  AuthService() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      baseUrl: baseUrl,
      contentType: 'application/json',
    );
  }

  static const String baseUrl = 'http://52.79.243.200:8080';

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/login',
        data: {
          'id': email,
          'password': password,
        },
      );
      Logger().i("response.data : ${response.data}");

      if (response.data['code'] == 200) {
        // 토큰 저장
        final accessToken = response.data['data']['accessToken'];
        Logger().i("accessToken : $accessToken");
        const storage = FlutterSecureStorage();
        await storage.write(key: 'accessToken', value: accessToken);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                response.data['message'].toString(),
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: ColorConstants.primaryColor,
            ),
          );
        }
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  // 회원가입
  Future<void> signUp(
      BuildContext context, UserProfileModel userProfileModel) async {
    try {
      Logger().i(userProfileModel.toJson());
      final response = await _dio.post(
        '$baseUrl/join/user',
        data: userProfileModel.toJson(),
      );
      Logger().i(response.data);
      if (context.mounted) {
        await login(context, userProfileModel.email, userProfileModel.password);
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
