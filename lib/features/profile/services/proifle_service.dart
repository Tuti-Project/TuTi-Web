import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../common/interceptor.dart';
import '../../../constants/color.dart';
import '../models/proifle_model.dart';

class ProfileService {
  final Dio _dio;
  ProfileService(this._dio) {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
    );
  }

  static const String baseUrl = 'http://52.79.243.200:8080';

  Future<ProfileModel> getProfile(BuildContext context) async {
    try {
      final response = await _dio.get('$baseUrl/my-page');
      if (response.statusCode == 200) {
        final result = response.data['data'];
        final profile = ProfileModel.fromJson(result);
        return profile;
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
    return ProfileModel.empty();
  }
}

final profileServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ProfileService(dio);
});
