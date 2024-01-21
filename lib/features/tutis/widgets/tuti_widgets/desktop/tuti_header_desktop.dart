import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/tuti_icon_title.dart';
import '../../../../../common/tuti_text.dart';
import '../../../../../constants/gaps.dart';
import '../../../views/home_screen.dart';
import '../../tuti_button_widget.dart';

class TuTiHeaderDesktop extends StatelessWidget {
  const TuTiHeaderDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 120.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TuTiIconTitle(title: 'tuti'),
          Gaps.w14,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TuTiText.medium(context, '트티'),
                    const Spacer(),
                    TuTiButton(
                      title: '퍼스널브랜딩',
                      onPressed: () {
                        context.pushNamed(HomeScreen.routeName);
                      },
                    ),
                    Gaps.w40,
                    TuTiButton(
                      title: '마이페이지',
                      onPressed: () {},
                    ),
                  ],
                ),
                Gaps.h20,
                TuTiText.small(
                  context,
                  '노는 것부터 스펙까지 트티가 다양한 길을 제안해줍니다!',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
