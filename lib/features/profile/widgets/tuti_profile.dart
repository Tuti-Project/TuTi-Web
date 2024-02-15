import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/common/tuti_text.dart';
import 'package:tuti/constants/gaps.dart';

class TuTiProfile extends StatelessWidget {
  const TuTiProfile({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TuTiText.medium(context, title),
        Gaps.w20,
        Text(
          data,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              fontFamily: 'Gothic_A1',
              fontSize: 12.sp,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
