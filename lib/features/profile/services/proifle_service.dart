import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:tuti/common/http_error_handler.dart';

import '../../../common/custom_interceptor.dart';
import '../../../common/tuti_snackbar.dart';
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
          '${StringConstants.baseUrl}/member/$memberId',
        );
      } else {
        response = await _dio.get('${StringConstants.baseUrl}/my-page');
      }
      if (response.data['code'] == 200) {
        final result = response.data['data'];
        final profile = ProfileModel.fromJson(result);
        return profile;
      } else {
        if (context.mounted) {
          HttpErrorHandler(context, response.data).handleResponse();
        }
      }
    } catch (e) {
      Logger().e("getMember : ${e.toString()}");
    }
    return ProfileModel.empty();
  }

  Future<void> updateProfile(BuildContext context, ProfileModel profile) async {
    try {
      final response = await _dio.put(
        '${StringConstants.baseUrl}/my-page',
        data: profile.toJson(),
      );
      if (response.data['code'] == 200) {
        if (context.mounted) {
          context.pop();
          TuTiSnackBar.showSnackBar(context, '프로필이 수정되었습니다.');
        }
      } else {
        if (context.mounted) {
          HttpErrorHandler(context, response.data).handleResponse();
        }
      }
    } catch (e) {
      Logger().e("updateProfile : ${e.toString()}");
    }
  }
}

final profileServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ProfileService(dio);
});
