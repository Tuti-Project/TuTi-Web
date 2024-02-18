import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/common/custom_token_manager.dart';
import 'package:tuti/common/service/navigation_index_provder.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/features/profile/models/member_model.dart';
import 'package:tuti/features/profile/views/profile_screen.dart';
import 'package:tuti/features/tutis/views/tuti_screen.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/tuti_login_dialog.dart';

import '../features/tutis/views/personal_branding_screen.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  static const routeName = 'mainNavigation';
  static const routeURL = 'main';

  const MainNavigationScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = ref.watch(navigationSelectedIndexProvider);

    void navigationToScreen(int index) {
      setState(() {
        // 유저가 클릭한 index를 navigationSelectedIndexProvider의 state에 할당
        ref.read(navigationSelectedIndexProvider.notifier).state = index;
      });
    }

    void onTap(int index) async {
      // 유저가 마이페이지로 이동 시 authToken이 있는지 검증
      // 토큰이 null || 비어있으면 로그인 안내 다이얼로그 띄움.
      if (index == 2) {
        String? authToken = await CustomTokenManager.getToken();
        if (authToken == null || authToken.isEmpty) {
          if (context.mounted) {
            await showDialog<void>(
              context: context,
              builder: (BuildContext context) => const LoginIntroDialog(),
            );
          }
        } else {
          navigationToScreen(index);
        }
        // 마이페이지로 이동하는 것이 아닐 때는 바로 이동
      } else {
        navigationToScreen(index);
      }
    }

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
                offstage: selectedIndex != 0,
                child: const PersonalBrandingScreen(),
              ),
              Offstage(
                offstage: selectedIndex != 1,
                child: const TuTiScreen(),
              ),
              Offstage(
                offstage: selectedIndex != 2,
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
              currentIndex: selectedIndex,
              onTap: onTap,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/personalBranding.png',
                    width: 24.w,
                    color: selectedIndex == 0
                        ? ColorConstants.primaryColor
                        : Colors.grey,
                  ),
                  label: '판매 서비스',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/home.png',
                    width: 24.w,
                    color: selectedIndex == 1
                        ? ColorConstants.primaryColor
                        : Colors.grey,
                  ),
                  label: '트티 홈',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/myPage.png',
                    width: 24.w,
                    color: selectedIndex == 2
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
