import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/features/auth/services/auth_service.dart';
import 'package:tuti/features/auth/widgets/auth_form_field.dart';
import 'package:tuti/features/tutis/widgets/tuti_button_widget.dart';

import '../../../constants/color.dart';
import '../../../constants/gaps.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login";
  static const String routePath = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late Map<String, String> formData = {};

  void _onSubmitTap() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        await AuthService()
            .login(context, formData['email']!, formData['password']!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/home_mobile.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.h20,
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 2,
                          color: ColorConstants.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: AuthFormField(
                      onEditingComplete: () {
                        if (formData['email'] != null &&
                            formData['email']!.isNotEmpty) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      onSaved: (newValue) => formData['email'] = newValue!,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return '이메일 아이디를 입력해주세요';
                        }
                        return null;
                      },
                      hintText: '이메일 아이디',
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Gaps.h40,
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 2,
                          color: ColorConstants.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: AuthFormField(
                      onEditingComplete: _onSubmitTap,
                      onSaved: (newValue) => formData['password'] = newValue!,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return '비밀번호를 입력해주세요';
                        }
                        return null;
                      },
                      hintText: '비밀번호',
                      obscureText: true,
                    ),
                  ),
                  Gaps.h40,
                  TuTiButton(
                    title: '개인회원 가입하기',
                    padding: EdgeInsets.symmetric(
                      horizontal: 35.w,
                    ),
                    fontSize: 15.sp,
                    onPressed: _onSubmitTap,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
