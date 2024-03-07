import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/common/constraints_scaffold.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/constants/gaps.dart';
import 'package:tuti/constants/string.dart';
import 'package:tuti/features/tutis/models/company_info.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/tuti_header_mobile.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/w_company_info_card.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  static const String routeName = "termsOfUse";
  static const String routePath = "/termsOfUse";

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['이용약관', '개인정보 처리방침', '환불 정책'];
    final CompanyInfo termsOfUse = CompanyInfo(
        title: '이용약관',
        contents: termsOfUseContents + minorContents + updateOfAccountInfo,
        onTap: () {});
    final CompanyInfo privacyPolicy = CompanyInfo(
        title: '개인정보 처리방침',
        contents: privacyPolicyIntroContents +
            privacyPolicyTableOfContents +
            privacyPolicyPurposeOfProcessingPersonalInfo +
            privacyPolicyProcessingRetentionPeriodOfPersonalInfo,
        onTap: () {});
    final CompanyInfo refundPolicy = CompanyInfo(
        title: '환불 정책',
        contents: refundPolicyServiceOfSales +
            refundPolicyCoachingRights +
            refundPolicyInquiry,
        onTap: () {});
    final List<CompanyInfo> companyInfos = [
      termsOfUse,
      privacyPolicy,
      refundPolicy
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: Column(
          children: [
            const TuTiHeaderMobile(),
            TabBar(
              indicatorColor: ColorConstants.primaryColor,
              labelColor: ColorConstants.primaryColor,
              dividerColor: ColorConstants.primaryColor,
              tabs: tabs.map((String name) => Text(name)).toList(),
            ),
            Flexible(
              flex: 11,
              child: TabBarView(
                children: companyInfos
                    .map((CompanyInfo info) => CompanyInfoCard(
                          title: info.title,
                          contents: info.contents,
                          onTap: info.onTap,
                        ))
                    .toList(),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
