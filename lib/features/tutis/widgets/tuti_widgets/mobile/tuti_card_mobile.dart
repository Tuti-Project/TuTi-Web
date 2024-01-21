import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/common/tuti_icon.dart';
import 'package:tuti/features/tutis/widgets/tuti_button_widget.dart';

import '../../../../../common/tuti_text.dart';
import '../../../../../constants/color.dart';
import '../../../../../constants/gaps.dart';
import '../../../models/profile_model.dart';

class TuTiCardMobile extends StatelessWidget {
  const TuTiCardMobile({
    super.key,
  });

  // keywords 의 길이가 4자 이상일 때 줄 바꿔서 String 으로 반환
  String _getKeyword(String keyword) {
    // keyword 의 길이가 4자 이상일 때 줄 바꿔서 반환
    if (keyword.length > 4) {
      return '${keyword.substring(0, 4)}\n${keyword.substring(4)}';
    }
    return keyword;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: profiles.length,
        separatorBuilder: (context, index) {
          return Gaps.h32;
        },
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 250.h,
                maxHeight: 250.h,
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
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLeftColumn(context, profile),
                  Gaps.w24,
                  _buildRightColumn(context, profile),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLeftColumn(BuildContext context, Map<String, Object> profile) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSwitchRow(context, profile),
          Gaps.h10,
          TuTiText.small(
            context,
            profile['isOn'] as bool ? '매칭 가능' : '재직 중',
            fontWeight: FontWeight.w900,
          ),
          Gaps.h6,
          _buildCircleAvatar(),
          Gaps.h8,
          TuTiText.small(
            context,
            profile['name'].toString(),
            fontWeight: FontWeight.w800,
          ),
          Gaps.h12,
          TuTiText.small(
            context,
            profile['university'].toString(),
            fontWeight: FontWeight.w800,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildRightColumn(BuildContext context, Map<String, Object> profile) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildKeywordsWrap(profile),
          TuTiButton(
            title: '더보기',
            onPressed: () {},
            padding: EdgeInsets.symmetric(
              horizontal: 35.w,
            ),
            fontSize: 10.sp,
          ),
          Gaps.h16,
        ],
      ),
    );
  }

  Widget _buildSwitchRow(BuildContext context, Map<String, Object> profile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 0.6,
          child: CupertinoSwitch(
            activeColor: ColorConstants.primaryColor,
            value: profile['isOn'] as bool,
            onChanged: (value) {},
          ),
        ),
        TuTiText.small(
          context,
          profile['isOn'] as bool ? 'on' : 'off',
          fontWeight: FontWeight.w900,
        ),
      ],
    );
  }

  Widget _buildCircleAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: ColorConstants.primaryColor,
        ),
      ),
      child: const CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('assets/images/fruit.png'),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget _buildKeywordsWrap(Map<String, Object> profile) {
    return Expanded(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 10.sp,
        children: [
          for (var keyword in profile['keywords'] as List<String>)
            TuTiIcon(
              title: _getKeyword(keyword),
              fontSize: 11.sp,
              iconHeight: 100.h,
            ),
        ],
      ),
    );
  }
}
