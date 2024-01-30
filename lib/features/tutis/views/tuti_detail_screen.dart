import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/common/constraints_scaffold.dart';
import 'package:tuti/common/tuti_text.dart';
import 'package:tuti/constants/gaps.dart';
import 'package:tuti/features/profile/models/proifle_model.dart';
import 'package:tuti/features/profile/widgets/tuti_container.dart';
import 'package:tuti/features/profile/widgets/tuti_profile.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/tuti_days.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/tuti_jobs.dart';

import '../../../constants/color.dart';
import '../../profile/services/proifle_service.dart';
import '../widgets/tuti_widgets/tuti_skills.dart';

class TuTiDetailScreen extends ConsumerStatefulWidget {
  const TuTiDetailScreen({
    Key? key,
    required this.memberId,
  }) : super(key: key);

  final int memberId;

  static const String routeName = "detail";
  static const String routePath = "detail";

  @override
  ConsumerState<TuTiDetailScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<TuTiDetailScreen> {

  Future<ProfileModel> getProfileBuilder() async {
    final profileService = ref.read(profileServiceProvider);
    final profile =
    await profileService.getProfile(context, memberId: widget.memberId);
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
              final isMatching = profile.applyMatchingStatus == "ON" ? true : false;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TuTiText.large(
                        context,
                        '${profile.name} 님',
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
                  ),
                  Gaps.h20,
                  TuTiText.medium(context, '관심직무',
                      color: ColorConstants.profileColor),
                  Gaps.h10,
                  if (profile.jobTags.isEmpty)
                    TuTiContainer(
                      text: profile.description,
                    ),
                  if (profile.jobTags.isNotEmpty) TuTiJobs(profile: profile),
                  Gaps.h20,
                  TuTiText.medium(context, '활용 능력',
                      color: ColorConstants.profileColor),
                  Gaps.h10,
                  if (profile.skillTags.isEmpty)
                    TuTiContainer(
                      text: profile.description,
                    ),
                  if (profile.skillTags.isNotEmpty) TuTiSkills(profile: profile),
                  Gaps.h20,
                  TuTiText.medium(context, '상세 설명 및 자격증',
                      color: ColorConstants.profileColor),
                  Gaps.h10,
                  TuTiContainer(
                    text: profile.description,
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
                            value: isMatching,
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (!isMatching) Gaps.h10,
                  if (!isMatching)
                    TuTiContainer(
                      text: profile.matchingDescription,
                    ),
                  Gaps.h20,
                  TuTiText.medium(context, '대면 업무 가능 시간',
                      color: ColorConstants.profileColor),
                  Gaps.h10,
                  TuTiDays(profile: profile),
                  Gaps.h10,
                  TuTiContainer(
                    text: profile.availableHours ?? "",
                  ),
                ],
              );
            }
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
}
