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
import 'package:tuti/features/profile/widgets/tuti_day.dart';
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
  void _editProfile() {
    context.pushNamed(EditProfileScreen.routePath, params: {'tab': 'profile'});
  }

  Future<ProfileModel> getProfileBuilder() async {
    final profileService = ref.read(profileServiceProvider);
    return await profileService.getProfile(context);
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
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            await getProfileBuilder();
          },
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TuTiText.large(
                              context,
                              '전연주 트티 반갑습니다!',
                            ),
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
                        children: [
                          _buildCircleAvatar(),
                          Gaps.w20,
                          const Column(
                            children: [
                              TuTiProfile(title: '이름', data: '전연주'),
                              Gaps.h5,
                              TuTiProfile(title: '나이', data: '전연주'),
                              Gaps.h5,
                              TuTiProfile(title: '성별', data: '전연주'),
                              Gaps.h5,
                              TuTiProfile(title: '학교', data: '전연주'),
                              Gaps.h5,
                              TuTiProfile(title: '학과', data: '전연주'),
                            ],
                          ),
                        ],
                      ),
                      Gaps.h20,
                      TuTiText.medium(context, '관심직무',
                          color: ColorConstants.profileColor),
                      Gaps.h10,
                      const IgnorePointer(
                        child: TuTiTextFormField(
                          hintText: '더 자세한 정보를 기입하면 매칭확률이 높아집니다!',
                        ),
                      ),
                      Gaps.h20,
                      TuTiText.medium(context, '활용 능력',
                          color: ColorConstants.profileColor),
                      Gaps.h10,
                      const IgnorePointer(
                        child: TuTiTextFormField(
                          hintText: '더 자세한 정보를 기입하면 매칭확률이 높아집니다!',
                        ),
                      ),
                      Gaps.h20,
                      TuTiText.medium(context, '상세 설명 및 자격증',
                          color: ColorConstants.profileColor),
                      Gaps.h10,
                      const IgnorePointer(
                        child: TuTiTextFormField(
                          hintText: '더 자세한 정보를 기입하면 매칭확률이 높아집니다!',
                        ),
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
                              value: true,
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                      Gaps.h40,
                      TuTiText.medium(context, '대면 업무 가능 시간',
                          color: ColorConstants.profileColor),
                      Gaps.h10,
                      // 월 ~ 일 까지 선택할 수 있는 컴포넌트
                      // 감싸는 위젯 wrap
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TuTiDay(day: '월'),
                          TuTiDay(day: '화'),
                          TuTiDay(day: '수'),
                          TuTiDay(day: '목'),
                          TuTiDay(day: '금'),
                          TuTiDay(day: '토'),
                          TuTiDay(day: '일'),
                        ],
                      ),
                    ],
                  );
                }),
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
              border: Border.all(
                width: 1,
                color: ColorConstants.primaryColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TuTiText.small(
              context,
              job,
              color: ColorConstants.primaryColor,
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
              border: Border.all(
                width: 1,
                color: ColorConstants.primaryColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TuTiText.small(
              context,
              skill,
              color: ColorConstants.primaryColor,
            ),
          ),
      ],
    );
  }
}
