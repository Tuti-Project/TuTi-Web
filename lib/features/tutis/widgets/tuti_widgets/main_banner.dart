import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/common/custom_token_manager.dart';
import 'package:tuti/common/service/navigation_index_provder.dart';
import 'package:tuti/common/service/token_provider.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/constants/gaps.dart';

class TuTiBanner extends ConsumerWidget {
  const TuTiBanner(
      {super.key,
      required this.onTap,
      required this.title,
      required this.subtitle,
      this.margin});

  final VoidCallback onTap;
  final String title;
  final String subtitle;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin ?? EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
        height: 80.h,
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
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 12.sp),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorConstants.primary600Color,
                      fontSize: 11.sp,
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
