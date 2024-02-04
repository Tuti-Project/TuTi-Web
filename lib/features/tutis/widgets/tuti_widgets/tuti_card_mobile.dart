import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/common/tuti_icon.dart';
import 'package:tuti/features/profile/models/member_model.dart';
import 'package:tuti/features/tutis/widgets/tuti_button_widget.dart';

import '../../../../common/tuti_text.dart';
import '../../../../constants/color.dart';
import '../../../../constants/gaps.dart';
import '../../../profile/services/member_service.dart';
import '../../views/tuti_detail_screen.dart';

class TuTiCardMobile extends ConsumerStatefulWidget {
  const TuTiCardMobile({
    super.key,
  });

  @override
  ConsumerState<TuTiCardMobile> createState() => _TuTiCardMobileState();
}

class _TuTiCardMobileState extends ConsumerState<TuTiCardMobile> {
  late ScrollController _scrollController;
  int _page = 0;
  List<MemberModel> _allMembers = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _initializeMemberData();
  }

  Future<void> _initializeMemberData() async {
    await getMembersBuilder(page: _page);
  }

  Future<List<MemberModel>> getMembersBuilder({required int page}) async {
    final memberService = ref.read(memberServiceProvider);
    print(page);
    final members = await memberService.getMembers(context, page);

    if (members.isNotEmpty) {
      setState(() {
        _allMembers.addAll(members);
      });
    }

    return _allMembers;
  }

  void _scrollListener() {
    // 리스트의 맨 아래에 도달했을 때
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      //서버에서 받아온 멤버 객체가 10의 배수일 때만 서버의 다음 페이지에 대한 멤버 정보를 받아옴.
      if (_allMembers.length % 10 == 0) {
        _page++;
        getMembersBuilder(page: _page);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _allMembers.length,
        itemBuilder: (context, index) {
          final member = _allMembers[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 250.h,
                maxHeight: 250.h,
              ),
              margin: EdgeInsets.symmetric(vertical: 10.sp),
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
            // member.applyMatchingStatus == 'ON' ? '매칭 가능' : member.matchingDescription.isNotEmpty ? member.matchingDescription : '재직 중',
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
            member.university == ''
                ? '미입력'
                : '${member.university} / ${member.major}',
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
            onPressed: () => _getDetailProfile(member.memberId),
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

  void _getDetailProfile(int memberId) async {
    if (context.mounted) {
      context.pushNamed(
        TuTiDetailScreen.routeName,
        params: {'tab': 'tuti'},
        queryParams: {
          'memberId': memberId.toString(),
        },
      );
    }
  }

  Widget _buildSwitchRow(BuildContext context, MemberModel member) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IgnorePointer(
          child: Transform.scale(
            scale: 0.6,
            child: CupertinoSwitch(
              activeColor: ColorConstants.primaryColor,
              value: member.applyMatchingStatus == 'ON' ? true : false,
              onChanged: (value) {},
            ),
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
      jobTags = ['미입력'];
    }
    return Expanded(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 10.sp,
        children: [
          for (var job in jobTags)
            TuTiIcon(
              title: job,
              fontSize: 11.sp,
              iconHeight: 100.h,
            ),
        ],
      ),
    );
  }
}
