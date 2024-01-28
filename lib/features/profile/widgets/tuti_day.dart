import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/tuti_text.dart';
import '../../../constants/color.dart';

class TuTiDay extends StatelessWidget {
  const TuTiDay({
    super.key,
    required this.day,
  });

  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            width: 1.0,
            color: ColorConstants.primaryColor,
          ),
        ),
        child: TuTiText.medium(context, day));
  }
}
