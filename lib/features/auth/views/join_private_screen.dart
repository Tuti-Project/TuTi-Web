import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/features/auth/models/user_profile_model.dart';
import 'package:tuti/features/auth/services/auth_service.dart';
import 'package:tuti/features/auth/widgets/auth_form_field.dart';
import 'package:tuti/features/tutis/views/tuti_screen.dart';

import '../../../common/tuti_text.dart';
import '../../../constants/color.dart';
import '../../../constants/gaps.dart';
import '../../tutis/widgets/tuti_button_widget.dart';

enum Terms {
  allTerms,
  ageTerms,
  serviceTerms,
  privacyTerms,
  marketingTermsSMS,
  marketingTermsEmail,
}

class JoinPrivateScreen extends StatefulWidget {
  const JoinPrivateScreen({super.key});

  static const String routeName = "joinPrivate";
  static const String routePath = "/joinPrivate";

  @override
  State<JoinPrivateScreen> createState() => _JoinPrivateScreenState();
}

class _JoinPrivateScreenState extends State<JoinPrivateScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String _email = '';
  String _password = '';
  String _passwordCheck = '';
  String _name = '';
  String _gender = '';

  int _selectedYear = 2000; // 년도
  String _selectedMonth = '01'; // 월
  String _selectedDay = '01'; // 일

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
    _passwordCheckController.addListener(() {
      setState(() {
        _passwordCheck = _passwordCheckController.text;
      });
    });
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordCheckController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  // 이메일 유효성
  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp =
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9 ]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return '이메일 형식이 올바르지 않습니다.';
    }
    return null;
  }

  // 비밀번호 유효성
  String? _isPasswordValid() {
    if (_password.isEmpty) return null;
    final regExp =
        RegExp(r"^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$");
    if (!regExp.hasMatch(_password)) {
      return '비밀번호 형식이 올바르지 않습니다.';
    }
    return null;
  }

  // 비밀번호 재입력 유효성
  String? _isPasswordCheckValid() {
    if (_passwordCheck.isEmpty) return null;
    if (_passwordCheck != _password) {
      return '비밀번호가 일치하지 않습니다.';
    }
    return null;
  }

  // 이름 유효성
  String? _validateName() {
    if (_name.isEmpty) return null;
    if (_name.length > 6 || _name.isEmpty) {
      return '이름은 6자 이하로 입력해주세요.';
    }
    return null;
  }

  final Set<Terms> _agreeToTerms = {};

  void _toggleSingleTerm(Terms term) {
    if (_isAllTermsAgreed()) return _agreeToTerms.clear();
    if (_agreeToTerms.contains(Terms.allTerms)) {
      _agreeToTerms.clear();
    } else {
      if (_agreeToTerms.contains(term)) {
        _agreeToTerms.remove(term);
      } else {
        _agreeToTerms.add(term);
      }
    }
  }

  // _aggreeToTerms에 모든 항목이 포함되어 있는지 확인
  bool _isAllTermsAgreed() {
    return _agreeToTerms.contains(Terms.allTerms) ||
        _agreeToTerms.containsAll(Terms.values) ||
        _agreeToTerms.length == Terms.values.length - 1;
  }

  bool _isTermsAgreed(Terms term) {
    if (_agreeToTerms.contains(Terms.allTerms)) return true;
    return _agreeToTerms.contains(term);
  }

  void signUp() async {
    if (!_agreeToTerms.contains(Terms.allTerms)) {
      if (!_agreeToTerms.contains(Terms.ageTerms)) return;
      if (!_agreeToTerms.contains(Terms.serviceTerms)) return;
      if (!_agreeToTerms.contains(Terms.privacyTerms)) return;
    }
    if (_email.isEmpty || _isEmailValid() != null) return;
    if (_password.isEmpty || _isPasswordValid() != null) return;
    if (_passwordCheck.isEmpty || _isPasswordCheckValid() != null) return;
    if (_name.isEmpty || _validateName() != null) return;
    if (_formKey.currentState!.validate() && _gender.isNotEmpty) {
      final userProfileModel = UserProfileModel(
        email: _email,
        password: _password,
        name: _name,
        birthYear: _selectedYear.toString(),
        birthDay: _selectedMonth.toString() + _selectedDay.toString(),
        gender: _gender,
      );
      await AuthService().signUp(context, userProfileModel);
      if (context.mounted) {
        context.pushNamed(TuTiScreen.routeName);
      }
      // 로그인 로직
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
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gaps.h20,
                  TuTiText.large(
                    context,
                    '개인 회원가입',
                  ),
                  Gaps.h40,
                  Container(
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
                    child: Column(
                      children: [
                        ListTile(
                          dense: true,
                          leading: Checkbox(
                            activeColor: ColorConstants.primaryColor,
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value: _isAllTermsAgreed(),
                            onChanged: (value) {
                              setState(() {
                                _toggleSingleTerm(Terms.allTerms);
                              });
                            },
                          ),
                          title: TuTiText.small(
                            context,
                            '이용약관에 전체동의',
                            textAlign: TextAlign.start,
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        ListTile(
                          dense: true,
                          leading: Checkbox(
                            activeColor: ColorConstants.primaryColor,
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value: _isTermsAgreed(Terms.ageTerms),
                            onChanged: (value) {
                              setState(() {
                                _toggleSingleTerm(Terms.ageTerms);
                              });
                            },
                          ),
                          title: TuTiText.small(
                            context,
                            '[필수]만 18세 이상입니다.',
                            textAlign: TextAlign.start,
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        ListTile(
                          dense: true,
                          leading: Checkbox(
                            activeColor: ColorConstants.primaryColor,
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value: _isTermsAgreed(Terms.serviceTerms),
                            onChanged: (value) {
                              setState(() {
                                _toggleSingleTerm(Terms.serviceTerms);
                              });
                            },
                          ),
                          title: TuTiText.small(
                            context,
                            '[필수]서비스 이용약관 동의',
                            textAlign: TextAlign.start,
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        ListTile(
                          dense: true,
                          leading: Checkbox(
                            activeColor: ColorConstants.primaryColor,
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value: _isTermsAgreed(Terms.privacyTerms),
                            onChanged: (value) {
                              setState(() {
                                _toggleSingleTerm(Terms.privacyTerms);
                              });
                            },
                          ),
                          title: TuTiText.small(
                            context,
                            '[필수]개인정보 수집 및 이용 동의',
                            textAlign: TextAlign.start,
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        ListTile(
                          dense: true,
                          leading: Checkbox(
                            activeColor: ColorConstants.primaryColor,
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value: _isTermsAgreed(Terms.marketingTermsSMS),
                            onChanged: (value) {
                              setState(() {
                                _toggleSingleTerm(Terms.marketingTermsSMS);
                              });
                            },
                          ),
                          title: TuTiText.small(
                            context,
                            '[선택]광고성 정보 수신 동의 [SMS/MMS]',
                            textAlign: TextAlign.start,
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        ListTile(
                          dense: true,
                          leading: Checkbox(
                            activeColor: ColorConstants.primaryColor,
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value: _isTermsAgreed(Terms.marketingTermsEmail),
                            onChanged: (value) {
                              setState(() {
                                _toggleSingleTerm(Terms.marketingTermsEmail);
                              });
                            },
                          ),
                          title: TuTiText.small(
                            context,
                            '[선택]광고성 정보 수신 동의 [이메일]',
                            textAlign: TextAlign.start,
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.w,
                            vertical: 15.h,
                          ),
                          child: Column(
                            children: [
                              TuTiText(
                                context,
                                '※ 개인정보 수집 및 이용에 대한 동의를 거부할 권리가 있으며 동의 거부 시에는 회원가입이 불가합니다.',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 10.sp,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              TuTiText(
                                context,
                                '※ 광고성 정보 수신 동의(SMS/MMS, 이메일) 모두 동의하실 경우에 5,000원 할인 쿠폰을 증정합니다.',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 10.sp,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.h20,
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            onEditingComplete: () {
                              if (_email.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (value) => _isEmailValid(),
                            hintText: '이메일',
                            errorText: _isEmailValid(),
                          ),
                        ),
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
                            controller: _passwordController,
                            obscureText: true,
                            onEditingComplete: () {
                              if (_password.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (_) => _isPasswordValid(),
                            hintText: '비밀번호 8 ~ 16자 영문, 숫자, 특수문자 조합',
                            errorText: _isPasswordValid(),
                          ),
                        ),
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
                            controller: _passwordCheckController,
                            obscureText: true,
                            onEditingComplete: () {
                              if (_password.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (_) => _isPasswordCheckValid(),
                            hintText: '비밀번호 재입력',
                            errorText: _isPasswordCheckValid(),
                          ),
                        ),
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
                            controller: _nameController,
                            onEditingComplete: () {
                              if (_name.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (_) => _validateName(),
                            hintText: '이름',
                            errorText: _validateName(),
                          ),
                        ),
                        Gaps.h20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<int>(
                                borderRadius: BorderRadius.circular(25),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: '연도',
                                  labelStyle: TextStyle(
                                    fontSize: 13.sp,
                                    color: ColorConstants.primaryColor,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: ColorConstants.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: ColorConstants.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                value: _selectedYear,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: ColorConstants.primaryColor,
                                ),
                                isExpanded: true,
                                items: List.generate(100,
                                        (index) => DateTime.now().year - index)
                                    .map((year) => DropdownMenuItem(
                                          value: year,
                                          child: Text(
                                            year.toString(),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) =>
                                    setState(() => _selectedYear = value!),
                              ),
                            ),
                            Gaps.w10,
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                borderRadius: BorderRadius.circular(25),
                                value: _selectedMonth,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: ColorConstants.primaryColor,
                                ),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: '월',
                                  labelStyle: TextStyle(
                                    fontSize: 13.sp,
                                    color: ColorConstants.primaryColor,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: ColorConstants.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: ColorConstants.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                onChanged: (value) =>
                                    setState(() => _selectedMonth = value!),
                                items: List.generate(12, (index) => index + 1)
                                    .map((month) => DropdownMenuItem(
                                          value:
                                              month < 10 ? '0$month' : '$month',
                                          child: Text(
                                            month < 10 ? '0$month' : '$month',
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                            Gaps.w10,
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                borderRadius: BorderRadius.circular(25),
                                value: _selectedDay,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: ColorConstants.primaryColor,
                                ),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: '일',
                                  labelStyle: TextStyle(
                                    fontSize: 13.sp,
                                    color: ColorConstants.primaryColor,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: ColorConstants.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: ColorConstants.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                onChanged: (value) =>
                                    setState(() => _selectedDay = value!),
                                items: List.generate(31, (index) => index + 1)
                                    .map((day) => DropdownMenuItem(
                                          value: day < 10 ? '0$day' : '$day',
                                          child: Text(
                                            day < 10 ? '0$day' : '$day',
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        Gaps.h20,
                        RadioListTile<String>(
                          fillColor: MaterialStateProperty.all(
                              ColorConstants.primaryColor),
                          contentPadding: EdgeInsets.zero,
                          activeColor: ColorConstants.primaryColor,
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          title: TuTiText.medium(
                            context,
                            '남자',
                            textAlign: TextAlign.start,
                          ),
                          value: 'M',
                          groupValue: _gender,
                          onChanged: (String? value) {
                            setState(() {
                              _gender = value ?? 'M';
                            });
                          },
                        ),
                        RadioListTile<String>(
                          fillColor: MaterialStateProperty.all(
                              ColorConstants.primaryColor),
                          contentPadding: EdgeInsets.zero,
                          activeColor: ColorConstants.primaryColor,
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          title: TuTiText.medium(
                            context,
                            '여자',
                            textAlign: TextAlign.start,
                          ),
                          value: 'F',
                          groupValue: _gender,
                          onChanged: (String? value) {
                            setState(() {
                              _gender = value ?? 'F';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Gaps.h20,
                  TuTiButton(
                    title: '가입하기',
                    onPressed: signUp,
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
