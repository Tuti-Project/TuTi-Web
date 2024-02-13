import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TuTiTextFormField extends StatelessWidget {
  const TuTiTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.limitLength = 50,
    this.style,
  });

  final String hintText;
  final TextEditingController? controller;
  final int limitLength;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      inputFormatters: [
        LengthLimitingTextInputFormatter(limitLength),
      ],
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        counterText: '',
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: hintText,
        hintMaxLines: 2,
        hintStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            width: 2,
            color: Colors.grey.shade200,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            width: 2,
            color: Colors.grey.shade200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            width: 2,
            color: Colors.grey.shade200,
          ),
        ),
      ),
    );
  }
}
