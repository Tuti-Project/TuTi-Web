import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/constants/media_query.dart';

class TuTiText extends Text {
  final BuildContext context;

  const TuTiText(
    this.context,
    String data, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) : super(
          data,
          key: key,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
        );

  factory TuTiText.large(
    BuildContext context,
    String data, {
    FontWeight? fontWeight,
    Color? color,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    final mq = MQ(context);
    return TuTiText(
      context,
      data,
      style: TextStyle(
        fontSize: mq.isMobile ? 20.sp : 36.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? ColorConstants.primaryColor,
      ),
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory TuTiText.medium(
    BuildContext context,
    String data, {
    FontWeight? fontWeight,
    Color? color,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    final mq = MQ(context);
    return TuTiText(
      context,
      data,
      style: TextStyle(
        fontSize: mq.isMobile ? 15.sp : 24.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? ColorConstants.primaryColor,
      ),
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory TuTiText.small(
    BuildContext context,
    String data, {
    FontWeight? fontWeight,
    Color? color,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    final mq = MQ(context);
    return TuTiText(
      context,
      data,
      style: TextStyle(
        fontSize: mq.isMobile ? 10.sp : 16.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? ColorConstants.primaryColor,
      ),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
