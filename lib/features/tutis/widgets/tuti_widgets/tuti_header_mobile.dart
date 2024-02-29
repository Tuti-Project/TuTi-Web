import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:logger/logger.dart';
import 'package:tuti/common/custom_token_manager.dart';
import 'package:tuti/common/service/token_provider.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/features/auth/services/auth_service.dart';
import 'package:tuti/features/auth/views/login_screen.dart';
import 'package:tuti/features/tutis/views/home_screen.dart';
import 'package:tuti/features/tutis/widgets/tuti_button_widget.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/tuti_login_dialog.dart';

import '../../../../common/tuti_icon_title.dart';
import '../../../../common/tuti_text.dart';
import '../../../../constants/gaps.dart';

class TuTiHeaderMobile extends ConsumerStatefulWidget {
  const TuTiHeaderMobile({
    super.key,
  });

  @override
  ConsumerState<TuTiHeaderMobile> createState() => _TuTiHeaderMobileState();
}

class _TuTiHeaderMobileState extends ConsumerState<TuTiHeaderMobile> {
  @override
  Widget build(BuildContext context) {
    // 토큰 유무 상태가 변경될 시 header 부분 rebuild
    String? token = ref.watch(tokenProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TuTiIconTitle(
            title: 'tuti',
            fontSize: 20.sp,
          ),
          Gaps.w14,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '트티',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 24.sp),
              ),
              Gaps.h5,
            ],
          ),
          const Spacer(),
          FutureBuilder<String?>(
            future: _getAuthToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  //TODO: 에러 발생 시 어떻게 처리할 것인지 추가 필요
                }
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty ||
                      snapshot.data == null ||
                      token == null ||
                      token.isEmpty) {
                    return TuTiButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 7.5.h, horizontal: 25.w),
                      fontSize: 10.sp,
                      title: '로그인',
                      onPressed: () => _showLoginDialog(context),
                    );
                  }
                }
              } else {
                return const RSizedBox();
              }
              return const RSizedBox();
            },
          ),
        ],
      ),
    );
  }

  Future<String?> _getAuthToken() async {
    String? authToken = await CustomTokenManager.getToken();
    return authToken;
  }

  void _showLoginDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => const LoginIntroDialog(),
    );
  }
}
