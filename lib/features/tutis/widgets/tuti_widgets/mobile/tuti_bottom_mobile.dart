import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/gaps.dart';
import '../../../views/home_screen.dart';
import '../../tuti_button_widget.dart';

class TuTiBottomMobile extends StatelessWidget {
  const TuTiBottomMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Padding(
        padding:
            EdgeInsets.only(top: 10.h, bottom: 30.h, left: 30.w, right: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TuTiButton(
                title: '퍼스널브랜딩',
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
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
