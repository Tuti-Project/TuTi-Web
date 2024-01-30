import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/common/tuti_text.dart';
import 'package:tuti/constants/gaps.dart';

class TuTiTextField extends StatelessWidget {
  const TuTiTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
  });

  final String title;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TuTiText.medium(
          context,
          title,
          textBaseline: TextBaseline.alphabetic,
        ),
        Gaps.w20,
        TextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
          ],
          controller: controller,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            constraints: BoxConstraints(
              maxWidth: 150.w,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }
}
