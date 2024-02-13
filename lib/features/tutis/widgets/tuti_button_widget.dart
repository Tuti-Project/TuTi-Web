import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/tuti_text.dart';
import '../../../constants/color.dart';

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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 35.w,
              vertical: 20.h,
            ),
        backgroundColor: ColorConstants.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPressed,
      child: TuTiText.small(
        context,
        title,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
