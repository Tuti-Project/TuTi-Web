import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/common/tuti_text.dart';

class TuTiContainer extends StatelessWidget {
  const TuTiContainer({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 20.h,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey.shade200,
        border: Border.all(
          width: 2,
          color: Colors.grey.shade200,
        ),
      ),
      child: TuTiText.medium(
        context,
        text,
        textAlign: TextAlign.start,
      ),
    );
  }
}
