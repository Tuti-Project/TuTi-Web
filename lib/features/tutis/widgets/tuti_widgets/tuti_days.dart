import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/tuti_text.dart';
import '../../../../constants/color.dart';
import '../../../../constants/string.dart';
import '../../../profile/models/proifle_model.dart';

class TuTiDays extends StatelessWidget {
  const TuTiDays({
    super.key,
    required this.profile,
  });

  final ProfileModel profile;

  List<String> sortedDay(List<String> selectedDay) {
    final sortedDay = selectedDay.map((day) {
      switch (day) {
        case 'MON':
          return '월';
        case 'TUE':
          return '화';
        case 'WED':
          return '수';
        case 'THU':
          return '목';
        case 'FRI':
          return '금';
        case 'SAT':
          return '토';
        case 'SUN':
          return '일';
        default:
          return '';
      }
    }).toList();
    return sortedDay;
  }

  @override
  Widget build(BuildContext context) {
    final selectedDay = profile.availableDays;
    final days = sortedDay(selectedDay);
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        for (final day in daysConstant)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 5.h,
            ),
            decoration: BoxDecoration(
              color: days.contains(day)
                  ? ColorConstants.primaryColor
                  : Colors.white,
              border: Border.all(
                width: 1,
                color: ColorConstants.primaryColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TuTiText.small(
              context,
              day,
              color: days.contains(day)
                  ? Colors.white
                  : ColorConstants.primaryColor,
            ),
          ),
      ],
    );
  }
}