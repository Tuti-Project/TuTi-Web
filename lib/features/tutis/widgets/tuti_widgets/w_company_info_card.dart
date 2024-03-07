import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/constants/gaps.dart';

class CompanyInfoCard extends StatelessWidget {
  const CompanyInfoCard({
    super.key,
    required this.title,
    required this.contents,
    this.subContents,
    this.subTitle,
    this.onTap,
  });

  final String title;
  final String contents;
  final String? subTitle;
  final String? subContents;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        margin: EdgeInsets.symmetric(horizontal: 45.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              contents,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w100),
            ),
            Gaps.h8,
            Visibility(
              visible: subTitle != null,
              child: Text(
                subTitle ?? '',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 11.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Gaps.h8,
            Visibility(
              visible: subContents != null,
              child: Text(
                subContents ?? '',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 10.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
