import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/common/constraints_scaffold.dart';
import 'package:tuti/common/tuti_text.dart';
import 'package:tuti/constants/gaps.dart';
import 'package:tuti/features/profile/models/proifle_model.dart';
import 'package:tuti/features/profile/services/proifle_service.dart';
import 'package:tuti/features/profile/widgets/tuti_profile.dart';

import '../../../constants/color.dart';
import '../../../constants/string.dart';
import '../widgets/tuti_textformfield.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String routeName = "profile";
  static const String routePath = "/profile";

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _descriptionController = TextEditingController();
  final _companyController = TextEditingController();
  final _timeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(() {
      setState(() {});
    });
    _companyController.addListener(() {
      setState(() {});
    });
    _timeController.addListener(() {
      setState(() {});
    });
  }

  ProfileModel _profile = ProfileModel.empty();
  final List<String> _selectedJob = [];
  final List<String> _selectedSkill = [];
  final List<String> _selectedDay = [];
  bool _isMatching = true;

  void _editProfile() {
    context.pushNamed(
      EditProfileScreen.routeName,
      params: {'tab': 'profile'},
      extra: _profile,
    );
  }

  Future<ProfileModel> getProfileBuilder() async {
    _selectedJob.clear();
    _selectedSkill.clear();
    _selectedDay.clear();
    _profile = ProfileModel.empty();

    final profileService = ref.read(profileServiceProvider);
    final profile = await profileService.getProfile(context);

    _selectedJob.addAll(profile.jobTags);
    _selectedSkill.addAll(profile.skillTags);

    for (final day in profile.availableDays) {
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

    _isMatching = profile.applyMatchingStatus == "ON" ? true : false;

    _profile = profile;

    _descriptionController.text = profile.description;
    _companyController.text = profile.matchingDescription;
    _timeController.text = profile.availableHours ?? "";

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
          child: FutureBuilder<ProfileModel>(
              future: getProfileBuilder(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('데이터를 불러오는데 실패했습니다.'),
                  );
                }
                final profile = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TuTiText.large(
                          context,
                          '${profile.name} 트티 반갑습니다!',
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                          ),
                          onPressed: _editProfile,
                          child: TuTiText.small(
                            context,
                            '수정',
                            style: TextStyle(
                              fontSize: 10.sp,
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
                                title: '이름', data: profile.name ?? "-"),
                            Gaps.h5,
                            TuTiProfile(
                                title: '나이', data: profile.age.toString()),
                            Gaps.h5,
                            TuTiProfile(
                                title: '성별', data: profile.gender ?? "-"),
                            Gaps.h5,
                            TuTiProfile(
                                title: '학교',
                                data: profile.university.isEmpty
                                    ? "-"
                                    : profile.university),
                            Gaps.h5,
                            TuTiProfile(
                                title: '학과',
                                data: profile.major.isEmpty
                                    ? "-"
                                    : profile.major),
                          ],
                        ),
                      ],
                    ),
                    Gaps.h20,
                    TuTiText.medium(context, '관심직무',
                        color: ColorConstants.profileColor),
                    Gaps.h10,
                    if (profile.jobTags.isEmpty)
                      const IgnorePointer(
                        child: TuTiTextFormField(
                          hintText: '더 자세한 정보를 기입하면 매칭확률이 높아집니다!',
                        ),
                      ),
                    if (profile.jobTags.isNotEmpty) _jobs(),
                    Gaps.h20,
                    TuTiText.medium(context, '활용 능력',
                        color: ColorConstants.profileColor),
                    Gaps.h10,
                    if (profile.skillTags.isEmpty)
                      const IgnorePointer(
                        child: TuTiTextFormField(
                          hintText: '더 자세한 정보를 기입하면 매칭확률이 높아집니다!',
                        ),
                      ),
                    if (profile.skillTags.isNotEmpty) _skill(),
                    Gaps.h20,
                    TuTiText.medium(context, '상세 설명 및 자격증',
                        color: ColorConstants.profileColor),
                    Gaps.h10,
                    IgnorePointer(
                      child: TuTiTextFormField(
                        hintText: '더 자세한 정보를 기입하면 매칭확률이 높아집니다!',
                        controller: _descriptionController,
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
                );
              }),
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
