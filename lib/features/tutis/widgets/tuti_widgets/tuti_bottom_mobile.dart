import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/gaps.dart';
import '../../../profile/views/profile_screen.dart';
import '../../views/home_screen.dart';
import '../tuti_button_widget.dart';

class TuTiBottomMobile extends StatefulWidget {
  const TuTiBottomMobile({
    super.key,
  });

  @override
  State<TuTiBottomMobile> createState() => _TuTiBottomMobileState();
}

class _TuTiBottomMobileState extends State<TuTiBottomMobile> {
  void _onTapMyPage() {
    context.pushNamed(ProfileScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TuTiButton(
              title: '퍼스널 브랜딩',
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 20.w,
              ),
              onPressed: () {
                context.pushNamed(HomeScreen.routeName);
              },
            ),
          ),
          Gaps.w10,
          Expanded(
            child: TuTiButton(
              title: '마이페이지',
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 20.w,
              ),
              onPressed: _onTapMyPage,
            ),
          ),
        ],
      ),
    );
  }
}
