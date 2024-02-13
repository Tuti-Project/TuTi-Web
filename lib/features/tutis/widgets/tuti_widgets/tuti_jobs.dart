import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/tuti_text.dart';
import '../../../../constants/color.dart';
import '../../../../constants/string.dart';
import '../../../profile/models/proifle_model.dart';

class TuTiJobs extends StatelessWidget {
  const TuTiJobs({
    super.key,
    required this.profile,
    this.getMember = false,
  });

  final ProfileModel profile;
  final bool getMember;

  @override
  Widget build(BuildContext context) {
    final selectedJob = profile.jobTags;
    final filteredJob =
        jobConstant.where((job) => selectedJob.contains(job)).toList();
    final jobs = getMember ? filteredJob : jobConstant;
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        for (final job in jobs)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 5.h,
            ),
            decoration: BoxDecoration(
              color: selectedJob.contains(job)
                  ? ColorConstants.primaryColor
                  : Colors.white,
              border: Border.all(
                width: 1,
                color: ColorConstants.primaryColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              job,
              style: TextStyle(
                  fontFamily: 'Gothic_A1',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: selectedJob.contains(job)
                      ? Colors.white
                      : ColorConstants.primaryColor),
            ),
          ),
      ],
    );
  }
}
