import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tuti/constants/color.dart';

class GoodsContainer extends StatelessWidget {
  const GoodsContainer(
      {super.key,
      required this.name,
      required this.discountedPrice,
      this.discountRate,
      this.regularPrice,
      this.discountPolicy});

  final String name;
  final double? regularPrice;
  final double? discountRate;
  final double discountedPrice;
  final String? discountPolicy;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(
      locale: 'ko_KR',
      symbol: '',
    );
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.symmetric(horizontal: 45.w, vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor,
          borderRadius: BorderRadius.circular(25.sp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            ),
            if (discountPolicy == '정액')
              Column(
                children: [
                  Text(
                    numberFormat.format(regularPrice),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 22.sp,
                        decoration: TextDecoration.lineThrough,
                        decorationColor:
                            ColorConstants.personalBrandingDividerColor,
                        decorationThickness: 2.0),
                  ),
                  Text(
                    '${numberFormat.format(discountRate)}원 할인',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18.sp,
                        color:
                            ColorConstants.personalBrandingTextHighlightColor),
                  ),
                ],
              ),
            if (discountPolicy == '정률')
              Column(
                children: [
                  Text(
                    numberFormat.format(regularPrice),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 22.sp,
                        decoration: TextDecoration.lineThrough,
                        decorationColor:
                            ColorConstants.personalBrandingDividerColor,
                        decorationThickness: 2.0),
                  ),
                  Text(
                    '${numberFormat.format(discountRate)}% 할인',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18.sp,
                        color:
                            ColorConstants.personalBrandingTextHighlightColor),
                  ),
                ],
              ),
            if (discountPolicy == '없음')
              Column(
                children: [
                  RSizedBox(height: 35.w),
                  RSizedBox(height: 35.w),
                ],
              ),
            Text(
              numberFormat.format(discountedPrice),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}
