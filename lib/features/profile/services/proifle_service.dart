import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../../common/custom_interceptor.dart';
import '../../../constants/color.dart';
import '../../../constants/string.dart';
import '../models/proifle_model.dart';

class ProfileService {
  final Dio _dio;
  ProfileService(this._dio);

  Future<ProfileModel> getMember(BuildContext context, {int? memberId}) async {
    try {
      Response? response;
      if (memberId != null) {
        response = await _dio.get(
            '${StringConstants.baseUrl}/member/{memberId}?memberId=$memberId');
      } else {
        response = await _dio.get('${StringConstants.baseUrl}/my-page');
      }
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

  Future<void> updateProfile(BuildContext context, ProfileModel profile) async {
    try {
      final response = await _dio.put(
        '${StringConstants.baseUrl}/my-page',
        data: profile.toJson(),
      );
      if (response.statusCode == 200) {
        if (context.mounted) {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                '프로필이 수정되었습니다.',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: ColorConstants.primaryColor,
            ),
          );
        }
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
}

final profileServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ProfileService(dio);
});
