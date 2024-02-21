import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/common/constraints_scaffold.dart';
import 'package:tuti/common/tuti_text.dart';
import 'package:tuti/constants/color.dart';
import 'package:tuti/features/tutis/models/goods.dart';
import 'package:tuti/features/tutis/views/goods_detail_screen.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/goods_container.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/main_banner.dart';
import 'package:universal_html/js.dart';

class PersonalBrandingScreen extends StatelessWidget {
  const PersonalBrandingScreen({super.key});

  static const String routeName = "personalBranding";
  static const String routePath = "/personalBranding";

  @override
  Widget build(BuildContext context) {
    return ConstraintsScaffold(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 35.h, bottom: 15.h),
            child: const TuTiBanner(
              location: GoodsDetailScreen.routePath,
              title: '오직, 트티에서만 제공하는\n2024년 당신의 커리어 고민 해결 솔루션.',
              subtitle: '체계적이고 알찬 개인 맞춤형 레벨업!',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: goodsCards.length,
              itemBuilder: (BuildContext context, index) {
                return GoodsContainer(
                    title: goodsCards[index].title,
                    regularPrice: goodsCards[index].regularPrice,
                    discountRate: goodsCards[index].discountRate,
                    discountedPrice: goodsCards[index].discountedPrice);
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<Goods> goodsCards = const [
  Goods(
      title: '강점 발견 연구소 1기',
      regularPrice: 600000,
      discountRate: 50,
      discountedPrice: 300000),
  Goods(title: '발표잘하는 방법 특강 1회', discountedPrice: 250000),
  Goods(title: '[건축학과] 공모전 컨설팅', discountedPrice: 250000),
  Goods(title: '내 성격에 맞는\n외모 스타일링 컨설팅', discountedPrice: 250000),
];
