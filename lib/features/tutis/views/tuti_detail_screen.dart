import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/common/constraints_scaffold.dart';
import 'package:tuti/common/tuti_text.dart';
import 'package:tuti/constants/gaps.dart';
import 'package:tuti/features/profile/models/proifle_model.dart';
import 'package:tuti/features/profile/widgets/tuti_profile.dart';

import '../../../constants/color.dart';
import '../../../constants/string.dart';
import '../../profile/widgets/tuti_textformfield.dart';

class TuTiDetailScreen extends ConsumerStatefulWidget {
  const TuTiDetailScreen({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final ProfileModel profile;

  static const String routeName = "profileDetail";
  static const String routePath = "/profileDetail";

  @override
  ConsumerState<TuTiDetailScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<TuTiDetailScreen> {
  late final TextEditingController _detailController =
      TextEditingController(text: widget.profile.description);
  late final TextEditingController _companyController =
      TextEditingController(text: widget.profile.matchingDescription);
  late final TextEditingController _timeController =
      TextEditingController(text: widget.profile.availableHours);
  late final TextEditingController _universityController =
      TextEditingController(text: widget.profile.university);
  late final TextEditingController _majorController = TextEditingController(
      text: widget.profile.major.isEmpty ? "-" : widget.profile.major);

  @override
  void initState() {
    super.initState();
    for (final day in widget.profile.availableDays) {
      switch (day) {
        case "MON":
          _selectedDay.add("월");
          break;
        case "TUE":
          _selectedDay.add("화");
          break;
        case "WED":
          _selectedDay.add("수");
          break;
        case "THU":
          _selectedDay.add("목");
          break;
        case "FRI":
          _selectedDay.add("금");
          break;
        case "SAT":
          _selectedDay.add("토");
          break;
        case "SUN":
          _selectedDay.add("일");
          break;
      }
    }
  }

  @override
  void dispose() {
    _detailController.dispose();
    _companyController.dispose();
    _timeController.dispose();
    _universityController.dispose();
    _majorController.dispose();
    super.dispose();
  }

  late final List<String> _selectedJob = widget.profile.jobTags;
  late final List<String> _selectedSkill = widget.profile.skillTags;
  late final List<String> _selectedDay = widget.profile.availableDays;
  late final bool _isMatching =
      widget.profile.applyMatchingStatus == "ON" ? true : false;

  @override
  Widget build(BuildContext context) {
    return ConstraintsScaffold(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
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
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TuTiText.large(
                      context,
                      '${widget.profile.name} 님',
                    ),
                  ],
                ),
                Gaps.h10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildCircleAvatar(),
                    Gaps.w20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TuTiProfile(
                            title: '이름', data: widget.profile.name ?? "-"),
                        Gaps.h5,
                        TuTiProfile(
                            title: '나이', data: widget.profile.age.toString()),
                        Gaps.h5,
                        TuTiProfile(
                            title: '성별', data: widget.profile.gender ?? "-"),
                        Gaps.h5,
                        TuTiProfile(
                            title: '학교',
                            data: widget.profile.university.isEmpty
                                ? "-"
                                : widget.profile.university),
                        Gaps.h5,
                        TuTiProfile(
                            title: '학과',
                            data: widget.profile.major.isEmpty
                                ? "-"
                                : widget.profile.major),
                      ],
                    ),
                  ],
                ),
                Gaps.h20,
                TuTiText.medium(context, '관심직무',
                    color: ColorConstants.profileColor),
                Gaps.h10,
                if (widget.profile.jobTags.isEmpty)
                  const IgnorePointer(
                    child: TuTiTextFormField(
                      hintText: '더 자세한 정보를 기입하면 매칭확률이 높아집니다!',
                    ),
                  ),
                if (widget.profile.jobTags.isNotEmpty) _jobs(),
                Gaps.h20,
                TuTiText.medium(context, '활용 능력',
                    color: ColorConstants.profileColor),
                Gaps.h10,
                if (widget.profile.skillTags.isEmpty)
                  const IgnorePointer(
                    child: TuTiTextFormField(
                      hintText: '더 자세한 정보를 기입하면 매칭확률이 높아집니다!',
                    ),
                  ),
                if (widget.profile.skillTags.isNotEmpty) _skill(),
                Gaps.h20,
                TuTiText.medium(context, '상세 설명 및 자격증',
                    color: ColorConstants.profileColor),
                Gaps.h10,
                IgnorePointer(
                  child: TuTiTextFormField(
                    controller: _detailController,
                    hintText: '더 자세한 정보를 기입하면 매칭확률이 높아집니다!',
                  ),
                ),
                Gaps.h20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TuTiText.medium(context, '직무매칭 인턴 신청 여부',
                        color: ColorConstants.profileColor),
                    IgnorePointer(
                      child: Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          activeColor: ColorConstants.primaryColor,
                          value: _isMatching,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
                if (!_isMatching) Gaps.h10,
                if (!_isMatching)
                  IgnorePointer(
                    child: TuTiTextFormField(
                      controller: _companyController,
                      hintText: '근무 중인 회사를 입력해주세요!',
                      limitLength: 30,
                    ),
                  ),
                Gaps.h20,
                TuTiText.medium(context, '대면 업무 가능 시간',
                    color: ColorConstants.profileColor),
                Gaps.h10,
                _days(),
                Gaps.h10,
                IgnorePointer(
                  child: TuTiTextFormField(
                    controller: _timeController,
                    hintText: '근무 가능 시간을 입력해주세요!',
                    limitLength: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

  Widget _jobs() {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        for (final job in jobConstant)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 5.h,
            ),
            decoration: BoxDecoration(
              color: _selectedJob.contains(job)
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
              job,
              color: _selectedJob.contains(job)
                  ? Colors.white
                  : ColorConstants.primaryColor,
            ),
          ),
      ],
    );
  }

  Widget _skill() {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        for (final skill in skillConstant)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 5.h,
            ),
            decoration: BoxDecoration(
              color: _selectedSkill.contains(skill)
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
              skill,
              color: _selectedSkill.contains(skill)
                  ? Colors.white
                  : ColorConstants.primaryColor,
            ),
          ),
      ],
    );
  }

  Widget _days() {
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
              color: _selectedDay.contains(day)
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
              color: _selectedDay.contains(day)
                  ? Colors.white
                  : ColorConstants.primaryColor,
            ),
          ),
      ],
    );
  }
}
