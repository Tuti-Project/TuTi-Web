import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/common/constraints_scaffold.dart';
import 'package:tuti/common/service/goods_provider.dart';
import 'package:tuti/common/tuti_text.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/features/tutis/models/company_info.dart';
import 'package:tuti/features/tutis/models/goods.dart';
import 'package:tuti/features/tutis/views/goods_detail_screen.dart';
import 'package:tuti/features/tutis/views/s_terms_of_use.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/goods_container.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/main_banner.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/w_company_info_card.dart';
import 'package:universal_html/js.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalBrandingScreen extends ConsumerWidget {
  const PersonalBrandingScreen({super.key});

  static const String routeName = "personalBranding";
  static const String routePath = "/personalBranding";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goodsList = ref.watch(goodsProvider);
    CompanyInfo companyInfo = CompanyInfo(
      title: '트티',
      contents: '기업명: (주) 이쿠아\n 주소: 서울 강남구 테헤란로22길 15 2층\n 전화: 010.7415.8850',
      onTap: () {
        String urlPath = 'info.tuti20.com';
        launchUrl(
          Uri.parse(urlPath),
        );
      },
    );
    CompanyInfo customerCenter = CompanyInfo(
      title: '고객센터',
      contents: '오전 10 ~ 오후 6시(주말, 공휴일 제외)\n문의하기: 010.7415.8850',
      subContents: '이용약관\n\n환불 정책\n\n제휴 및 대외협력',
      subTitle: '개인정보처리방침',
      onTap: () {
        context.push(TermsOfUseScreen.routePath);
      },
    );

    List<CompanyInfo> companyInfos = [companyInfo, customerCenter];

    return ConstraintsScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 130.h,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              background: TuTiBanner(
                onTap: () {},
                margin: EdgeInsets.only(
                    top: 35.h, bottom: 15.h, left: 40.w, right: 40.w),
                title: '오직, 트티에서만 제공하는\n2024년 당신의 커리어 고민 해결 솔루션.',
                subtitle: '체계적이고 알찬 개인 맞춤형 레벨업!',
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount:
                  goodsList.value?.length ?? 0, // Handle null values gracefully
              (context, index) {
                if (goodsList.hasValue) {
                  return GoodsContainer(
                    name: goodsList.value![index].name,
                    discountRate: goodsList.value![index].discountRate,
                    regularPrice: goodsList.value![index].regularPrice,
                    discountedPrice: goodsList.value![index].discountedPrice,
                    discountPolicy: goodsList.value![index].discountPolicy,
                  );
                } else if (goodsList.hasError) {
                  return SliverToBoxAdapter(
                    child: Text('Error: ${goodsList.error}'),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: companyInfos.length,
              (context, index) {
                return CompanyInfoCard(
                  title: companyInfos[index].title,
                  contents: companyInfos[index].contents,
                  subTitle: companyInfos[index].subTitle,
                  subContents: companyInfos[index].subContents,
                  onTap: companyInfos[index].onTap,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
