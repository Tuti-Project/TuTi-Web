import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/common/tuti_icon.dart';
import 'package:tuti/features/tutis/widgets/tuti_button_widget.dart';

import '../../../../../common/tuti_text.dart';
import '../../../../../constants/color.dart';
import '../../../../../constants/gaps.dart';
import '../../../../../constants/media_query.dart';
import '../../../../profile/models/profile_model.dart';

class TuTiCardDesktop extends StatelessWidget {
  const TuTiCardDesktop({
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

  double _calculateAspectRatio(BuildContext context) {
    final mqWidth = MQ(context).width;

    if (mqWidth >= 1890) {
      return 0.6;
    } else if (mqWidth >= 1536) {
      return 0.55;
    } else if (mqWidth >= 1200) {
      return 0.35;
    } else if (mqWidth >= 1020) {
      return 0.3;
    } else {
      return 0.2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ratio = _calculateAspectRatio(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 100,
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: ratio * 100.w,
            crossAxisSpacing: ratio * 100.w,
            childAspectRatio: ratio,
          ),
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            final profile = profiles[index];
            return SingleChildScrollView(
              child: Container(
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
                    Gaps.h44,
                    _buildSwitchRow(context, profile),
                    Gaps.h20,
                    TuTiText.medium(
                      context,
                      profile['isOn'] as bool ? '매칭 가능' : '재직 중',
                      fontWeight: FontWeight.w900,
                    ),
                    Gaps.h20,
                    _buildCircleAvatar(),
                    Gaps.h44,
                    TuTiText.medium(
                      context,
                      profile['name'].toString(),
                      fontWeight: FontWeight.w800,
                    ),
                    Gaps.h16,
                    TuTiText.medium(
                      context,
                      profile['university'].toString(),
                      fontWeight: FontWeight.w800,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.h44,
                    _buildKeywordsWrap(profile),
                    Gaps.h44,
                    TuTiButton(
                      title: '더보기',
                      onPressed: () {},
                    ),
                    Gaps.h16,
                  ],
                ),
              ),
            );
          },
        ),
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
        TuTiText.medium(
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
    return Wrap(
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
    );
  }
}
