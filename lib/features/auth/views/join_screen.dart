import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:tuti/features/tutis/widgets/tuti_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/tuti_text.dart';
import '../../../constants/color.dart';
import '../../../constants/gaps.dart';
import 'join_private_screen.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  static const String routeName = "join";
  static const String routePath = "/join";

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      Logger().i('url: $url');
      if (url.contains('kakao')) {
        String code = Uri.parse(url).queryParameters['code']!;
        Logger().i('code: $code');
        flutterWebviewPlugin.close();
      }
    });
  }

  // 개입회원 가입하기 버튼
  void _register() {
    context.pushNamed(JoinPrivateScreen.routeName);
  }

  // 기업회원 가입하기 버튼
  void _registerCompany() {}

  // 카카오 회원가입
  void _registerKakao() async {
    String kakaoAuthUrl =
        'https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=7ff146a57fe3bd78600ad06449f6caaf&redirect_uri=http://52.79.243.200:8080/login/oauth/code/kakao';
    Uri uri = Uri.parse(kakaoAuthUrl);
    await launchUrl(uri);
    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri);
    // } else {
    //   Logger().e('Could not launch $kakaoAuthUrl');
    // }
  }

  // 네이버 회원가입
  void _registerNaver() async {
    String naverAuthUrl =
        'https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=3acx2vHkOvIWkdbPEiyM&redirect_uri=http://52.79.243.200:8080/login/oauth2/code/naver';
    Uri uri = Uri.parse(naverAuthUrl);
    await launchUrl(uri);
    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri);
    // } else {
    //   Logger().e('Could not launch $naverAuthUrl');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TuTiText.medium(
          context,
          '트티 회원가입',
        ),
      ),
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
                children: [
                  // 개인 회원가입 컨테이너
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                      vertical: 40.h,
                    ),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 2,
                          color: ColorConstants.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/fruit.png',
                          width: 150.w,
                          height: 200.h,
                          fit: BoxFit.fill,
                        ),
                        Gaps.h20,
                        TuTiText(
                          context,
                          '개 인 회 원',
                          style: TextStyle(
                            color: ColorConstants.primaryColor,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Gaps.h20,
                        TuTiText(
                          context,
                          '트티가 되어 학기 중에 취업과 관련된 업무 능력을 활용해 보세요!',
                          style: TextStyle(
                            color: ColorConstants.primaryColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gaps.h20,
                        TuTiButton(
                          title: '개인회원 가입하기',
                          padding: EdgeInsets.symmetric(
                            horizontal: 35.w,
                          ),
                          fontSize: 15.sp,
                          onPressed: _register,
                        ),
                        Gaps.h20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: _registerKakao,
                              child: Image.asset(
                                'assets/images/kakao.png',
                                width: 50.w,
                                height: 50.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Gaps.w40,
                            GestureDetector(
                              onTap: _registerNaver,
                              child: Image.asset(
                                'assets/images/naver.png',
                                width: 50.w,
                                height: 50.h,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gaps.h40,
                  // 기업 회원가입 컨테이너
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                      vertical: 40.h,
                    ),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 2,
                          color: ColorConstants.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/ship.png',
                          width: 150.w,
                          height: 200.h,
                          fit: BoxFit.fill,
                        ),
                        Gaps.h20,
                        TuTiText(
                          context,
                          '기 업 회 원',
                          style: TextStyle(
                            color: ColorConstants.primaryColor,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Gaps.h20,
                        TuTiText(
                          context,
                          '기업회원이 되어 똑똑한 트티와 함께 회사를 발전시켜보세요!\n(사업자등록번호 필수입력)',
                          style: TextStyle(
                            color: ColorConstants.primaryColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gaps.h20,
                        TuTiButton(
                          title: '기업회원 가입하기',
                          padding: EdgeInsets.symmetric(
                            horizontal: 35.w,
                          ),
                          fontSize: 15.sp,
                          onPressed: _registerCompany,
                        ),
                        Gaps.h20,
                        TuTiText(
                          context,
                          '빠르고 간편한 대학생 헤드헌팅 대행\n010-7415-8850',
                          style: TextStyle(
                            color: ColorConstants.primaryColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
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
