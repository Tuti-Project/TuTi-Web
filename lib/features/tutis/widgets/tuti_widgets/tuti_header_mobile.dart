import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:logger/logger.dart';
import 'package:tuti/common/custom_token_manager.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/features/auth/services/auth_service.dart';
import 'package:tuti/features/auth/views/login_screen.dart';
import 'package:tuti/features/tutis/views/home_screen.dart';
import 'package:tuti/features/tutis/widgets/tuti_button_widget.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/tuti_login_dialog.dart';

import '../../../../common/tuti_icon_title.dart';
import '../../../../common/tuti_text.dart';
import '../../../../constants/gaps.dart';

class TuTiHeaderMobile extends StatefulWidget {
  const TuTiHeaderMobile({
    super.key,
  });

  @override
  State<TuTiHeaderMobile> createState() => _TuTiHeaderMobileState();
}

class _TuTiHeaderMobileState extends State<TuTiHeaderMobile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
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
                  if (snapshot.data!.isEmpty || snapshot.data == null) {
                    return TuTiButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 25.w),
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
