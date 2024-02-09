import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:logger/logger.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/features/auth/services/auth_service.dart';
import 'package:tuti/features/auth/views/login_screen.dart';
import 'package:tuti/features/tutis/views/home_screen.dart';

import '../../../../common/tuti_icon_title.dart';
import '../../../../common/tuti_text.dart';
import '../../../../constants/gaps.dart';

class TuTiHeaderMobile extends StatelessWidget {
  const TuTiHeaderMobile({
    super.key,
  });

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
              TuTiText.medium(
                context,
                '트티',
              ),
              Gaps.h5,
              TuTiText.small(
                context,
                '노는 것부터 스펙까지\n'
                '트티가 다양한 길을 제안해줍니다!',
                textAlign: TextAlign.start,
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll<Color>(ColorConstants.primaryColor),
            ),
            onPressed: () {
              print('버튼이 클릭됐어요');
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: 300.w, maxHeight: 460.h),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(40.w, 20.h, 40.w, 20.h),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: loginSheetTexts(context)),
                              const Spacer(),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: loginIntroButtonCollection(context)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: TuTiText.small(
              context,
              '로그인',
              color: Colors.white,
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }
}

Widget loginSheetTexts(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RSizedBox(
        width: 56.w,
        height: 70.h,
        child: Image.asset('assets/images/fruit.png'),
      ),
      TuTiText.small(context, '회원가입 / 로그인하기'),
      TuTiText.large(context, '오직 트티에만 있는'),
      TuTiText.large(context, '다양한 서비스를'),
      TuTiText.large(context, '확인해보세요!'),
    ],
  );
}

Widget loginIntroButtonCollection(BuildContext context) {
  return Column(
    children: [
      loginButtonTemplete(context,
          foregroundText: '로그인하기', routePath: '/login'),
      Gaps.h8,
      loginButtonTemplete(context,
          foregroundText: '회원가입하기', routePath: '/join'),
      Gaps.h8,
      socialLoginButton(
        context,
        foregroundText: '카카오 로그인하기',
        imagePath: 'assets/images/kakao.png',
        backGroundColor: ColorConstants.kakaoColor,
      ),
      Gaps.h8,
      socialLoginButton(context,
          foregroundText: '네이버 로그인하기',
          imagePath: 'assets/images/naver.png',
          backGroundColor: ColorConstants.naverColor),
    ],
  );
}

Widget socialLoginButton(BuildContext context,
    {String? foregroundText,
    String? imagePath,
    Color? backGroundColor,
    VoidCallback? onPressed}) {
  return ElevatedButton(
    // 카카오, 네이버 로그인하기 구현 시 onPressed 작성
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: backGroundColor,
      fixedSize: Size(180.w, 30.h),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RSizedBox(
          width: 14.w,
          height: 14.h,
          child: Image.asset(imagePath!),
        ),
        Gaps.w4,
        TuTiText.small(
          context,
          foregroundText!,
          style: TextStyle(fontSize: 12.sp, color: Colors.white),
        ),
      ],
    ),
  );
}

Widget loginButtonTemplete(BuildContext context,
    {String? foregroundText, String? routePath}) {
  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      fixedSize: Size(180.w, 30.h),
      backgroundColor: ColorConstants.primaryColor,
      foregroundColor: Colors.white);
  return ElevatedButton(
    onPressed: () {
      context.go(routePath!);
    },
    style: buttonStyle,
    child: Text(
      foregroundText!,
      style: TextStyle(fontSize: 12.sp),
    ),
  );
}
