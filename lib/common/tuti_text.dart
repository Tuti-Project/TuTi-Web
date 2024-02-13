import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/constants/color.dart';

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
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) : super(
          data,
          key: key,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign ?? TextAlign.center,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaler: textScaler,
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
    TextAlign? textAlign,
  }) {
    return TuTiText(
      context,
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: color),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.center,
    );
  }

  factory TuTiText.medium(
    BuildContext context,
    String data, {
    TextStyle? style,
    FontWeight? fontWeight,
    Color? color,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
    TextBaseline? textBaseline,
  }) {
    return TuTiText(
      context,
      data,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: color),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.center,
    );
  }

  factory TuTiText.small(
    BuildContext context,
    String data, {
    FontWeight? fontWeight,
    Color? color,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
    TextStyle? style,
  }) {
    return TuTiText(
      context,
      data,
      style: style ??
          Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: color, fontWeight: FontWeight.w900),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
