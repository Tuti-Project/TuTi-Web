import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/features/tutis/widgets/tuti_button_widget.dart';

import '../../../../common/tuti_icon_title.dart';
import '../../../../common/tuti_text.dart';
import '../../../../constants/color.dart';
import '../../../../constants/gaps.dart';
import '../../../auth/views/join_screen.dart';
import '../../../auth/views/login_screen.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({Key? key}) : super(key: key);

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  // 로그인 함수
  void _login() {
    context.pushNamed(LoginScreen.routeName);
  }

  // 회원가입
  void _register() {
    context.pushNamed(JoinScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Gaps.w52,
          Column(
            children: [
              Gaps.h52,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TuTiIconTitle(title: 'tuti'),
                  Gaps.w8,
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10.h,
                    ),
                    child: TuTiText(
                      context,
                      '트티',
                      style: TextStyle(
                        color: ColorConstants.primaryColor,
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.h20,
              TuTiText.medium(
                context,
                'Welcome to tuti',
              ),
              Gaps.h8,
              TuTiText.medium(
                context,
                'Let’s begin the adventure',
              ),
              Gaps.h52,
              TuTiButton(
                title: '로그인',
                onPressed: _login,
              ),
              Gaps.h14,
              TuTiButton(
                title: '회원가입',
                onPressed: _register,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
