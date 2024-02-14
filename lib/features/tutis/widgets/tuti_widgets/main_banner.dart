import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/constants/gaps.dart';
import 'package:tuti/features/tutis/views/personal_branding_screen.dart';

class TuTiBanner extends StatelessWidget {
  const TuTiBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(PersonalBrandingScreen.routePath);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2.w, color: ColorConstants.primaryColor),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RSizedBox(
              width: 40.w,
              height: 44.h,
              child: Image.asset('assets/images/fruit.png'),
            ),
            Gaps.w10,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '[공지]\n트티 강점 발견 연구소 1기 모집 중!',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 12.sp),
                ),
                Text(
                  '🤯 인생 고민, 진로 고민 ! 미래에 대한 확신이 들지 않을 때!',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorConstants.primary600Color,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
