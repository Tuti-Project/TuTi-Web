import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/tuti_text.dart';
import '../../../../constants/color.dart';
import '../../../../constants/media_query.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MQ(context);
    return Container(
      width: double.infinity,
      height: mq.isMobile ? 200.h : 250.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF7AF0FB), Color(0xFFCCFAFF)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TuTiText(
            context,
            '중학교, 고등학교 졸업하고 나면 찾아 오는 방황.',
            style: TextStyle(
              color: ColorConstants.primaryColor,
              fontSize: mq.isMobile ? 15.sp : 30.sp,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          TuTiText(
            context,
            '트티가입으로 이제는 끝.',
            style: TextStyle(
              color: ColorConstants.primaryColor,
              fontSize: mq.isMobile ? 15.sp : 30.sp,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
