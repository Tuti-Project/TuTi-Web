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

  Future<List<MemberModel>> getMembers(BuildContext context, int page) async {
    try {
      final response =
          await _dio.get('${StringConstants.baseUrl}/home?page=$page');
      if (response.data['code'] == 200) {
        final List<dynamic> result = response.data['data']['members'];
        final members = result.map((e) => MemberModel.fromJson(e)).toList();
        return members;
      } else {
        if (context.mounted) {
          HttpErrorHandler(context, response.data).handleResponse();
        }
      }
    } catch (e) {
      Logger().e("getMembers : ${e.toString()}");
    }
    return [];
  }
}

final memberServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return MemberService(dio);
});
