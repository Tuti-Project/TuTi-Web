import 'package:flutter/material.dart';
import 'package:tuti/common/tuti_text.dart';

import '../constants/color.dart';

class TuTiIcon extends StatelessWidget {
  const TuTiIcon({
    super.key,
    required this.title,
    required this.fontSize,
    this.iconHeight,
  });

  final String title;
  final double fontSize;
  final double? iconHeight;

  final String assetName = "assets/images/medal.png";

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          assetName,
          width: fontSize * 6.5,
          height: iconHeight ?? fontSize * 6.5,
        ),
        Positioned(
          top: (iconHeight ?? fontSize * 6.5) * 0.32,
          child: TuTiText(
            context,
            title,
            style: TextStyle(
              color: ColorConstants.primaryColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}
