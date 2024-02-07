import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:tuti/constants/string.dart';

import '../../../common/custom_interceptor.dart';
import '../../../common/http_error_handler.dart';
import '../models/member_model.dart';

class MemberService {
  final Dio _dio;
  MemberService(this._dio);

  Future<Map<String, dynamic>> initialGetMembers(BuildContext context) async {
    try {
      final response = await _dio.get('${StringConstants.baseUrl}/home');
      if (response.data['code'] == 200) {
        final List<dynamic> result = response.data['data']['members'];
        final int lastMemberId = response.data['data']['last'];
        final bool hasNext = response.data['data']['hasNext'];
        final members = result.map((e) => MemberModel.fromJson(e)).toList();
        final Map<String, dynamic> homeData = {
          'members': members,
          'last': lastMemberId,
          'hasNext': hasNext,
        };
        return homeData;
      } else {
        if (context.mounted) {
          HttpErrorHandler(context, response.data).handleResponse();
        }
      }
    } catch (e) {
      Logger().e("getMembers : ${e.toString()}");
    }
    return {};
  }

  Future<Map<String, dynamic>> scrollGetMembers(
      BuildContext context, int memberId) async {
    try {
      final response =
          await _dio.get('${StringConstants.baseUrl}/home?last=$memberId');
      if (response.data['code'] == 200) {
        final List<dynamic> result = response.data['data']['members'];
        final int lastMemberId = response.data['data']['last'];
        final bool hasNext = response.data['data']['hasNext'];
        final members = result.map((e) => MemberModel.fromJson(e)).toList();
        final Map<String, dynamic> homeData = {
          'members': members,
          'last': lastMemberId,
          'hasNext': hasNext,
        };
        return homeData;
      } else {
        if (context.mounted) {
          HttpErrorHandler(context, response.data).handleResponse();
        }
      }
    } catch (e) {
      Logger().e("getMembers : ${e.toString()}");
    }
    return {};
  }
}

final memberServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return MemberService(dio);
});
