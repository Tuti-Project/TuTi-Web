import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthFormField extends StatelessWidget {
  final VoidCallback onEditingComplete;
  final Function(String?)? onSaved;
  final Function(String?) validator;
  final String? initialValue;
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? errorText;
  final TextStyle? style;

  const AuthFormField({
    Key? key,
    required this.onEditingComplete,
    this.onSaved,
    required this.validator,
    this.initialValue,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.errorText,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      controller: controller,
      obscureText: obscureText,
      autocorrect: !obscureText,
      enableSuggestions: !obscureText,
      keyboardType: keyboardType,
      onEditingComplete: onEditingComplete,
      initialValue: initialValue,
      onSaved: onSaved,
      validator: (value) => validator(value),
      decoration: InputDecoration(
        errorText: errorText,
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 12.sp,
            color: Colors.grey,
            textBaseline: TextBaseline.alphabetic),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
