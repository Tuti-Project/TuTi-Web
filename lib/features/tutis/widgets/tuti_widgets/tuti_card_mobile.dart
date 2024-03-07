import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/common/custom_token_manager.dart';
import 'package:tuti/common/service/navigation_index_provder.dart';
import 'package:tuti/common/service/token_provider.dart';
import 'package:tuti/common/tuti_icon.dart';
import 'package:tuti/features/profile/models/member_model.dart';
import 'package:tuti/features/tutis/views/s_personal_branding.dart';
import 'package:tuti/features/tutis/widgets/tuti_button_widget.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/main_banner.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/tuti_login_dialog.dart';

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
  final List<MemberModel> _allMembers = [];
  final List<int> _lastMemberIds = [];
  final List<bool> _hasNextPages = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _initializeMemberData();
  }

  Future<void> _initializeMemberData() async {
    final memberService = ref.read(memberServiceProvider);
    final homeData = await memberService.initialGetMembers(context);
    final members = homeData['members'];
    final lastMemberId = homeData['last'];
    final bool hasNext = homeData['hasNext'];
    _lastMemberIds.add(lastMemberId);
    _hasNextPages.add(hasNext);

    if (members.isNotEmpty) {
      setState(() {
        _allMembers.addAll(members);
      });
    }
  }

  void _scrollListener() {
    // 리스트의 맨 아래에 도달했을 때
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_hasNextPages.last == true) {
        getMembersBuilder();
      }
    }
  }

  Future<void> getMembersBuilder() async {
    final memberService = ref.read(memberServiceProvider);
    final homeData =
        await memberService.scrollGetMembers(context, _lastMemberIds.last);
    final members = homeData['members'];
    final lastMemberId = homeData['last'];
    final bool hasNext = homeData['hasNext'];
    _lastMemberIds.add(lastMemberId);
    _hasNextPages.add(hasNext);

    if (members.isNotEmpty) {
      setState(() {
        _allMembers.addAll(members);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          expandedHeight: 80.h,
          floating: false,
          pinned: false,
          flexibleSpace: FlexibleSpaceBar(
            background: TuTiBanner(
              onTap: () {
                // 판매페이지 탭으로 이동
                ref.read(navigationSelectedIndexProvider.notifier).state = 0;
              },
              title: '[공지]\n트티 강점 발견 연구소 1기 모집 중!',
              subtitle: '🤯 인생 고민, 진로 고민 ! 미래에 대한 확신이 들지 않을 때!',
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          delegate: SliverChildBuilderDelegate(childCount: _allMembers.length,
              (context, index) {
            final member = _allMembers[index];
            return Container(
              margin: EdgeInsets.all(8.w),
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
              child: Padding(
                padding: EdgeInsets.all(7.w),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLeftColumn(context, member),
                    _buildRightColumn(context, member),
                  ],
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  Widget _buildLeftColumn(BuildContext context, MemberModel member) {
    String? token = ref.watch(tokenProvider);

    String _maskName(String name) {
      if (name.length >= 3) {
        return name.replaceRange(1, 2, '*');
      } else if (name.length == 2) {
        String firstName = name.substring(0, 1);
        String maskName = firstName + "*";
        return maskName;
      }
      return name;
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSwitchRow(context, member),
          TuTiText.small(
            context,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 10.sp, fontWeight: FontWeight.w800),
            member.applyMatchingStatus == 'ON' ? '매칭 가능' : '재직 중',
            // member.applyMatchingStatus == 'ON' ? '매칭 가능' : member.matchingDescription.isNotEmpty ? member.matchingDescription : '재직 중',
          ),
          Gaps.h6,
          _buildCircleAvatar(),
          Gaps.h8,
          TuTiText.small(
            context,
            token == null || token.isEmpty
                ? _maskName(member.name)
                : member.name,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 9.sp, fontWeight: FontWeight.w900),
          ),
          Gaps.h6,
          TuTiText.small(
            context,
            member.university == ''
                ? '미입력'
                : '${member.university}\n${member.major}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 8.sp, fontWeight: FontWeight.w900),
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
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 15.w),
            title: '더보기',
            onPressed: () async {
              String? authToken = await CustomTokenManager.getToken();
              if (authToken == null || authToken.isEmpty) {
                if (context.mounted) {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => const LoginIntroDialog(),
                  );
                }
              } else {
                _getDetailProfile(member.memberId);
              }
            },
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
        radius: 20,
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
              fontSize: 9.sp,
              iconHeight: 60.h,
            ),
        ],
      ),
    );
  }
}
