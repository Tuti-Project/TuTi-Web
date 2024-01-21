import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/tuti_icon_title.dart';
import '../../../../../common/tuti_text.dart';
import '../../../../../constants/gaps.dart';

class TuTiHeaderMobile extends StatelessWidget {
  const TuTiHeaderMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TuTiIconTitle(title: 'tuti'),
          Gaps.w14,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TuTiText.medium(
                context,
                '트티',
              ),
              Gaps.h5,
              TuTiText.small(
                context,
                '노는 것부터 스펙까지\n'
                '트티가 다양한 길을 제안해줍니다!',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
