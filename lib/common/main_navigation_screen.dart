import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/common/custom_token_manager.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/features/profile/models/member_model.dart';
import 'package:tuti/features/profile/views/profile_screen.dart';
import 'package:tuti/features/tutis/views/tuti_screen.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/tuti_login_dialog.dart';

import '../features/tutis/views/personal_branding_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  static const routeName = 'mainNavigation';
  static const routeURL = 'main';
  final String tab;

  const MainNavigationScreen({
    Key? key,
    required this.tab,
  }) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _tabs = [
    'personalBranding',
    'tuti',
    'profile',
  ];
  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) async {
    // 유저가 마이페이지로 이동 시 authToken이 있는지 검증
    // 토큰이 null || 비어있으면 로그인 안내 다이얼로그 띄움.
    if (index == 2) {
      String? authToken = await CustomTokenManager.getToken();
      if (authToken == null || authToken.isEmpty) {
        if (mounted) {
          await showDialog<void>(
            context: context,
            builder: (BuildContext context) => const LoginIntroDialog(),
          );
        }
      } else {
        _navigationToScreen(index);
      }
      // 마이페이지로 이동하는 것이 아닐 때는 바로 이동
    } else {
      _navigationToScreen(index);
    }
  }

  void _navigationToScreen(int index) {
    if (mounted) {
      context.go('/${_tabs[index]}');
      setState(
        () {
          _selectedIndex = index;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 700.w,
        ),
        child: Scaffold(
          // 키보드 열었을 때 화면이 위로 올라가는 것을 방지
          // resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Offstage(
                offstage: _selectedIndex != 0,
                child: const PersonalBrandingScreen(),
              ),
              Offstage(
                offstage: _selectedIndex != 1,
                child: const TuTiScreen(),
              ),
              Offstage(
                offstage: _selectedIndex != 2,
                child: const ProfileScreen(),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBarTheme(
            data: const BottomNavigationBarThemeData(
              elevation: 1,
              selectedItemColor: ColorConstants.primaryColor,
              unselectedItemColor: Colors.grey,
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onTap,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/personalBranding.png',
                    width: 24.w,
                    color: _selectedIndex == 0
                        ? ColorConstants.primaryColor
                        : Colors.grey,
                  ),
                  label: '퍼스널브랜딩',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/home.png',
                    width: 24.w,
                    color: _selectedIndex == 1
                        ? ColorConstants.primaryColor
                        : Colors.grey,
                  ),
                  label: '직무 매칭',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/myPage.png',
                    width: 24.w,
                    color: _selectedIndex == 2
                        ? ColorConstants.primaryColor
                        : Colors.grey,
                  ),
                  label: '마이페이지',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
