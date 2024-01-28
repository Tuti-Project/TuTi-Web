import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/common/constraints_scaffold.dart';
import 'package:tuti/features/profile/models/proifle_model.dart';

import '../../../common/tuti_text.dart';
import '../../../constants/color.dart';
import '../../../constants/gaps.dart';
import '../../../constants/string.dart';
import '../services/proifle_service.dart';
import '../widgets/tuti_profile.dart';
import '../widgets/tuti_textfield.dart';
import '../widgets/tuti_textformfield.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.profile,
  });

  final ProfileModel profile;

  static const String routeName = "editProfile";
  static const String routePath = "editProfile";

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
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

  late String _detail = widget.profile.description;
  late String _company = widget.profile.matchingDescription;
  late String? _time = widget.profile.availableHours;
  late String _university = widget.profile.university;
  late String _major = widget.profile.major;

  @override
  void initState() {
    super.initState();
    _detailController.addListener(() {
      setState(() {
        _detail = _detailController.text;
      });
    });
    _companyController.addListener(() {
      setState(() {
        _company = _companyController.text;
      });
    });
    _timeController.addListener(() {
      setState(() {
        _time = _timeController.text;
      });
    });
    _universityController.addListener(() {
      setState(() {
        _university = _universityController.text;
      });
    });
    _majorController.addListener(() {
      setState(() {
        _major = _majorController.text;
      });
    });
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

  late bool _isMatching =
      widget.profile.applyMatchingStatus == "ON" ? true : false;

  late final List<String> _selectedJob = widget.profile.jobTags;
  late final List<String> _selectedSkill = widget.profile.skillTags;
  late final List<String> _selectedDay = [];

  void _onSelectedJob(String job) {
    setState(() {
      setState(() {
        if (_selectedJob.contains(job)) {
          _selectedJob.remove(job);
        } else {
          if (_selectedJob.length >= 2) return;
          _selectedJob.add(job);
        }
      });
    });
  }

  void _onSelectedSkill(String skill) {
    setState(() {
      if (_selectedSkill.contains(skill)) {
        _selectedSkill.remove(skill);
      } else {
        if (_selectedSkill.length >= 10) return;
        _selectedSkill.add(skill);
      }
    });
  }

  void _onSelectedDay(String day) {
    setState(() {
      if (_selectedDay.contains(day)) {
        _selectedDay.remove(day);
      } else {
        _selectedDay.add(day);
      }
    });
  }

  void _submit() async {
    final profileService = ref.read(profileServiceProvider);

    List<String> selectedDay = [];
    for (final day in _selectedDay) {
      switch (day) {
        case "월":
          selectedDay.add("MON");
          break;
        case "화":
          selectedDay.add("TUE");
          break;
        case "수":
          selectedDay.add("WED");
          break;
        case "목":
          selectedDay.add("THU");
          break;
        case "금":
          selectedDay.add("FRI");
          break;
        case "토":
          selectedDay.add("SAT");
          break;
        case "일":
          selectedDay.add("SUN");
          break;
      }
    }

    final profile = ProfileModel(
      university: _university,
      major: _major,
      jobTags: _selectedJob,
      skillTags: _selectedSkill,
      description: _detail,
      applyMatchingStatus: _isMatching ? "ON" : "OFF",
      availableDays: selectedDay,
      matchingDescription: _company,
      availableHours: _time,
    );
    await profileService.updateProfile(context, profile);
  }

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TuTiText.large(
                    context,
                    '마이페이지 수정',
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                    onPressed: _submit,
                    child: TuTiText.small(
                      context,
                      '완료',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                      ),
                    ),
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
                      TuTiTextField(
                        title: '학교',
                        controller: _universityController,
                        hintText: widget.profile.university.isEmpty
                            ? "-"
                            : widget.profile.university,
                      ),
                      Gaps.h5,
                      TuTiTextField(
                        title: '학과',
                        controller: _majorController,
                        hintText: widget.profile.major.isEmpty
                            ? "-"
                            : widget.profile.major,
                      ),
                    ],
                  ),
                ],
              ),
              Gaps.h20,
              TuTiText.medium(context, '관심직무',
                  color: ColorConstants.profileColor),
              Gaps.h10,
              _jobs(),
              Gaps.h20,
              TuTiText.medium(context, '활용 능력',
                  color: ColorConstants.profileColor),
              Gaps.h10,
              _skill(),
              Gaps.h20,
              TuTiText.medium(context, '상세 설명 및 자격증',
                  color: ColorConstants.profileColor),
              Gaps.h10,
              TuTiTextFormField(
                controller: _detailController,
                hintText: '더 자세한 정보를 기입하면 매칭확률이 높아집니다!',
              ),
              Gaps.h20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TuTiText.medium(context, '직무매칭 인턴 신청 여부',
                      color: ColorConstants.profileColor),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      activeColor: ColorConstants.primaryColor,
                      value: _isMatching,
                      onChanged: (value) {
                        setState(() {
                          _isMatching = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              if (!_isMatching) Gaps.h10,
              if (!_isMatching)
                TuTiTextFormField(
                  controller: _companyController,
                  hintText: '근무 중인 회사를 입력해주세요!',
                  limitLength: 30,
                ),
              Gaps.h20,
              TuTiText.medium(context, '대면 업무 가능 시간',
                  color: ColorConstants.profileColor),
              Gaps.h10,
              _days(),
              Gaps.h10,
              TuTiTextFormField(
                controller: _timeController,
                hintText: '근무 가능 시간을 입력해주세요!',
                limitLength: 30,
              ),
            ],
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
          InkWell(
            onTap: () => _onSelectedJob(job),
            child: Container(
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
          InkWell(
            onTap: () => _onSelectedSkill(skill),
            child: Container(
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
          InkWell(
            onTap: () => _onSelectedDay(day),
            child: Container(
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
          ),
      ],
    );
  }
}
