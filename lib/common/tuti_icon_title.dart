import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/common/tuti_text.dart';

import '../constants/color.dart';
import '../constants/media_query.dart';

class TuTiIconTitle extends StatelessWidget {
  const TuTiIconTitle({
    super.key,
    required this.title,
    this.fontSize,
  });

  final String title;
  final double? fontSize;
  final String assetName = "assets/images/medal.png";

  @override
  Widget build(BuildContext context) {
    final mq = MQ(context);
    final double baseFontSize = mq.isMobile ? 18.sp : 40.sp;
    final double adjustedFontSize = fontSize ?? baseFontSize;

    // 계산된 텍스트 길이에 따라 가운데 정렬 조절
    final double iconWidth = mq.isMobile ? 55 : 110;

    // TextPainter 대신에 RichText를 사용하여 텍스트 너비 계산
    final TextSpan span = TextSpan(
      text: title,
      style: TextStyle(
        fontSize: adjustedFontSize,
        fontWeight: FontWeight.w800,
      ),
    );
    final TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    final double textWidth = tp.width;
    final double leftPosition = (iconWidth - textWidth) / 2;

    return Stack(
      children: [
        Image.asset(
          assetName,
          width: mq.isMobile ? 55 : 110,
          height: mq.isMobile ? 70 : 140,
        ),
        Positioned(
          top: mq.isMobile ? 16.h : 30.h,
          left: mq.isMobile ? leftPosition : 22.w,
          child: RSizedBox(
            width: iconWidth,
            child: TuTiText(
              context,
              title,
              style: TextStyle(
                color: ColorConstants.primaryColor,
                fontSize: adjustedFontSize,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
