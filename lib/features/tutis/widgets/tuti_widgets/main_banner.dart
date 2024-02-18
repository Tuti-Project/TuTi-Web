import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/constants/gaps.dart';

class TuTiBanner extends StatelessWidget {
  const TuTiBanner(
      {super.key,
      required this.location,
      required this.title,
      required this.subtitle});

  final String location;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(location);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
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
