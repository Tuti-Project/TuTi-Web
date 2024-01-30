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
  const EditProfileScreen({super.key});

  static const String routeName = "editProfile";
  static const String routePath = "editProfile";

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late final TextEditingController _detailController = TextEditingController();
  late final TextEditingController _companyController = TextEditingController();
  late final TextEditingController _timeController = TextEditingController();
  late final TextEditingController _universityController = TextEditingController();
  late final TextEditingController _majorController = TextEditingController();

  late String _detail = '';
  late String _company = '';
  late String? _time = '';
  late String _university = '';
  late String _major = '';

  @override
  void initState() {
    super.initState();
    getProfileBuilder();
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

  late bool _isMatching = true;

  late final List<String> _selectedJob = [];
  late final List<String> _selectedSkill = [];
  late final List<String> _selectedDay = [];

  late String _name = "";
  late String _age = "";
  late String _gender = "";

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

  Future<ProfileModel> getProfileBuilder() async {
    final profileService = ref.read(profileServiceProvider);
    final profile = await profileService.getProfile(context);

    profile.applyMatchingStatus == "ON" ? _isMatching = true : _isMatching = false;
    _universityController.text = profile.university;
    _majorController.text = profile.major.isEmpty ? "-" : profile.major;
    _detailController.text = profile.description;
    _companyController.text = profile.matchingDescription;
    _timeController.text = profile.availableHours ?? "";
    _selectedJob.addAll(profile.jobTags);
    _selectedSkill.addAll(profile.skillTags);
    _selectedDay.addAll(profile.availableDays);

    _name = profile.name ?? "-";
    _age = profile.age.toString();
    _gender = profile.gender ?? "-";

    return profile;
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildCircleAvatar(),
                    Gaps.w20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TuTiProfile(
                            title: '이름', data: _name),
                        Gaps.h5,
                        TuTiProfile(
                            title: '나이', data: _age),
                        Gaps.h5,
                        TuTiProfile(
                            title: '성별', data: _gender),
                        Gaps.h5,
                        TuTiTextField(
                          title: '학교',
                          controller: _universityController,
                          hintText: _university.isEmpty
                              ? "-"
                              : _university,
                        ),
                        Gaps.h5,
                        TuTiTextField(
                          title: '학과',
                          controller: _majorController,
                          hintText: _major.isEmpty
                              ? "-"
                              : _major,
                        ),
                      ],
                    ),
                  ],
                ),
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
