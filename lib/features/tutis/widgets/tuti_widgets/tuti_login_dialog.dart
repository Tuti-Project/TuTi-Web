import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/common/tuti_text.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/constants/gaps.dart';

class LoginIntroDialog extends StatelessWidget {
  const LoginIntroDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: BoxConstraints(maxWidth: 350.w, maxHeight: 530.h),
        padding: EdgeInsets.fromLTRB(40.w, 30.h, 40.w, 30.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.sp),
        ),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft, child: loginSheetTexts(context)),
            Gaps.h28,
            Align(
                alignment: Alignment.centerRight,
                child: loginIntroButtonCollection(context)),
          ],
        ),
      ),
    );
  }
}

Widget loginSheetTexts(BuildContext context) {
  TextStyle loginIntroTextStyle =
      Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24.sp);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RSizedBox(
        width: 56.w,
        height: 70.h,
        child: Image.asset('assets/images/fruit.png'),
      ),
      Gaps.h8,
      TuTiText.small(
        context,
        '회원가입 / 로그인하기',
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w100),
      ),
      Gaps.h12,
      TuTiText(
        context,
        '오직 트티에만 있는\n다양한 서비스를\n확인해보세요!',
        style: loginIntroTextStyle,
        textAlign: TextAlign.start,
      ),
    ],
  );
}

Widget loginIntroButtonCollection(BuildContext context) {
  return Column(
    children: [
      loginButtonTemplete(context,
          foregroundText: '로그인하기', routePath: '/login'),
      Gaps.h4,
      loginButtonTemplete(context,
          foregroundText: '회원가입하기', routePath: '/join'),
      Gaps.h4,
      socialLoginButton(
        context,
        foregroundText: '카카오 로그인하기',
        imagePath: 'assets/images/kakao.png',
        backGroundColor: ColorConstants.kakaoColor,
      ),
      Gaps.h4,
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
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.h),
    child: ElevatedButton(
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
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontSize: 12.sp, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

Widget loginButtonTemplete(BuildContext context,
    {String? foregroundText, String? routePath}) {
  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      fixedSize: Size(180.w, 30.h),
      backgroundColor: ColorConstants.primaryColor,
      foregroundColor: Colors.white);
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.h),
    child: ElevatedButton(
      onPressed: () {
        context.go(routePath!);
      },
      style: buttonStyle,
      child: Text(
        foregroundText!,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(fontSize: 12.sp, color: Colors.white),
      ),
    ),
  );
}
