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
import 'package:tuti/features/tutis/models/goods.dart';
import 'package:tuti/features/tutis/views/goods_detail_screen.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/goods_container.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/main_banner.dart';
import 'package:universal_html/js.dart';

class PersonalBrandingScreen extends ConsumerWidget {
  const PersonalBrandingScreen({super.key});

  static const String routeName = "personalBranding";
  static const String routePath = "/personalBranding";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Goods>> goodsList = ref.watch(goodsProvider);

    return ConstraintsScaffold(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 35.h, bottom: 15.h),
            child: TuTiBanner(
              onTap: () {},
              title: '오직, 트티에서만 제공하는\n2024년 당신의 커리어 고민 해결 솔루션.',
              subtitle: '체계적이고 알찬 개인 맞춤형 레벨업!',
            ),
          ),
          Expanded(
            child: switch (goodsList) {
              AsyncData(:final value) => ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) => GoodsContainer(
                    name: value[index].name,
                    discountRate: value[index].discountRate,
                    regularPrice: value[index].regularPrice,
                    discountedPrice: value[index].discountedPrice,
                    discountPolicy: value[index].discountPolicy,
                  ),
                ),
              AsyncError() => const Text('Oops, something unexpected happened'),
              AsyncLoading() => const CircularProgressIndicator(),
              _ => const CircularProgressIndicator(),
            },
          ),
        ],
      ),
    );
  }
}
