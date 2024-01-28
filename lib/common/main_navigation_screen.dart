import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/features/profile/views/profile_screen.dart';
import 'package:tuti/features/tutis/views/tuti_screen.dart';

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

  void _onTap(int index) {
    context.go('/${_tabs[index]}');
    setState(() {
      _selectedIndex = index;
    });
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
                  // Icon(
                  //   Icons.bar_chart,
                  //   color: _selectedIndex == 0
                  //       ? ColorConstants.primaryColor
                  //       : Colors.grey,
                  // ),
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
                  label: '트티 홈',
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
