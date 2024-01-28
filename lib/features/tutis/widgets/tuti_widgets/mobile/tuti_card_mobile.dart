import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/common/tuti_icon.dart';
import 'package:tuti/features/profile/models/member_model.dart';
import 'package:tuti/features/tutis/widgets/tuti_button_widget.dart';

import '../../../../../common/tuti_text.dart';
import '../../../../../constants/color.dart';
import '../../../../../constants/gaps.dart';
import '../../../../profile/services/member_service.dart';

class TuTiCardMobile extends ConsumerStatefulWidget {
  const TuTiCardMobile({
    super.key,
  });

  @override
  ConsumerState<TuTiCardMobile> createState() => _TuTiCardMobileState();
}

class _TuTiCardMobileState extends ConsumerState<TuTiCardMobile> {
  Future<List<MemberModel>> getMembersBuilder() async {
    final memberService = ref.read(memberServiceProvider);
    return await memberService.getMembers(context);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator.adaptive(
        onRefresh: () async {
          await getMembersBuilder();
        },
        child: FutureBuilder<List<MemberModel>>(
            future: getMembersBuilder(),
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
              final members = snapshot.data!;
              return ListView.separated(
                itemCount: members.length,
                separatorBuilder: (context, index) {
                  return Gaps.h32;
                },
                itemBuilder: (context, index) {
                  final member = members[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 250.h,
                        maxHeight: 250.h,
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
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildLeftColumn(context, member),
                          Gaps.w24,
                          _buildRightColumn(context, member),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }

  Widget _buildLeftColumn(BuildContext context, MemberModel member) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSwitchRow(context, member),
          Gaps.h10,
          TuTiText.small(
            context,
            member.applyMatchingStatus == 'ON' ? '매칭 가능' : '재직 중',
            fontWeight: FontWeight.w900,
          ),
          Gaps.h6,
          _buildCircleAvatar(),
          Gaps.h8,
          TuTiText.small(
            context,
            member.name,
            fontWeight: FontWeight.w800,
          ),
          Gaps.h12,
          TuTiText.small(
            context,
            member.university == '' ? '미입력' : member.university,
            fontWeight: FontWeight.w800,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildRightColumn(BuildContext context, MemberModel member) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildKeywordsWrap(member),
          TuTiButton(
            title: '더보기',
            onPressed: () {},
            padding: EdgeInsets.symmetric(
              horizontal: 35.w,
            ),
            fontSize: 10.sp,
          ),
          Gaps.h16,
        ],
      ),
    );
  }

  Widget _buildSwitchRow(BuildContext context, MemberModel member) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 0.6,
          child: CupertinoSwitch(
            activeColor: ColorConstants.primaryColor,
            value: member.applyMatchingStatus == 'ON' ? true : false,
            onChanged: (value) {},
          ),
        ),
        TuTiText.small(
          context,
          member.applyMatchingStatus == 'ON' ? 'on' : 'off',
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

  Widget _buildKeywordsWrap(MemberModel member) {
    var jobTags = member.jobTags;
    if (jobTags.isEmpty) {
      jobTags = ['미입력', '미입력'];
    }
    return Expanded(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 10.sp,
        children: [
          TuTiIcon(
            title: jobTags[0],
            fontSize: 11.sp,
            iconHeight: 100.h,
          ),
          TuTiIcon(
            title: jobTags[1],
            fontSize: 11.sp,
            iconHeight: 100.h,
          ),
        ],
      ),
    );
  }
}
