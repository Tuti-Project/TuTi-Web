import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/tuti_text.dart';
import '../../../constants/color.dart';
import '../../../constants/media_query.dart';

class TuTiButton extends StatelessWidget {
  const TuTiButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.padding,
    this.fontSize,
  });

  final String title;
  final VoidCallback onPressed;
  final EdgeInsets? padding;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final mq = MQ(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: mq.isMobile ? 35.w : 70.w,
              vertical: mq.isMobile ? 20.h : 20.h,
            ),
        backgroundColor: ColorConstants.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPressed,
      child: TuTiText(
        context,
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize ?? (mq.isMobile ? 15.sp : 24.sp),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
