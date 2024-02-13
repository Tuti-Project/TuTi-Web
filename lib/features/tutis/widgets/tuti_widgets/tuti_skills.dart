import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/tuti_text.dart';
import '../../../../constants/color.dart';
import '../../../../constants/string.dart';
import '../../../profile/models/proifle_model.dart';

class TuTiSkills extends StatelessWidget {
  const TuTiSkills({
    super.key,
    required this.profile,
    this.getMember = false,
  });

  final ProfileModel profile;
  final bool getMember;

  @override
  Widget build(BuildContext context) {
    final selectedSkill = profile.skillTags;
    final filteredSkill =
        skillConstant.where((skill) => selectedSkill.contains(skill)).toList();
    final skills = getMember ? filteredSkill : skillConstant;
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        for (final skill in skills)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 5.h,
            ),
            decoration: BoxDecoration(
              color: selectedSkill.contains(skill)
                  ? ColorConstants.primaryColor
                  : Colors.white,
              border: Border.all(
                width: 1,
                color: ColorConstants.primaryColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              skill,
              style: TextStyle(
                  fontFamily: 'Gothic_A1',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: selectedSkill.contains(skill)
                      ? Colors.white
                      : ColorConstants.primaryColor),
            ),
          ),
      ],
    );
  }
}
