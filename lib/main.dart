import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:tuti/constants/string.dart';
import 'package:tuti/router.dart';

import 'constants/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  // const nativeAppKey = '4b00f616a81b54e28b1ec7f62cc4ca62';
  // KakaoSdk.init(nativeAppKey: nativeAppKey);
  const javaScriptAppKey = 'e8672714e4155899ffebc63eccc5e671';
  KakaoSdk.init(javaScriptAppKey: javaScriptAppKey);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    const ProviderScope(
      child: TuTi(),
    ),
  );
}

class TuTi extends ConsumerWidget {
  const TuTi({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: ScreenUtilInit(
        designSize: Size(width, height),
        minTextAdapt: true,
        child: MaterialApp.router(
          builder: (context, child) {
            return Theme(
              data: themeData,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.1),
                ),
                child: child!,
              ),
            );
          },
          title: StringConstants.appName,
          routerConfig: ref.watch(routerProvider),
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

ThemeData themeData = ThemeData(
  textTheme: TextTheme(
    labelMedium: TextStyle(
      fontFamily: 'Gothic A1',
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: ColorConstants.primaryColor,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Gothic A1',
      fontSize: 11.sp,
      fontWeight: FontWeight.w500,
      color: ColorConstants.primaryColor,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Gothic A1',
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: ColorConstants.primaryColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Gothic A1',
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: ColorConstants.primaryColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Gothic A1',
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      color: ColorConstants.primaryColor,
    ),
    titleLarge: TextStyle(
      fontFamily: 'SB 어그로',
      fontSize: 22.sp,
      fontWeight: FontWeight.w400,
      color: ColorConstants.primaryColor,
    ),
    titleMedium: TextStyle(
      fontFamily: 'SB 어그로',
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: ColorConstants.primaryColor,
    ),
    titleSmall: TextStyle(
      fontFamily: 'SB 어그로',
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: ColorConstants.primaryColor,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Gothic A1',
      fontSize: 32.sp,
      fontWeight: FontWeight.w400,
      color: ColorConstants.primaryColor,
    ),
    displayMedium: TextStyle(
      fontFamily: 'SB 어그로',
      fontSize: 45.sp,
      fontWeight: FontWeight.w400,
      color: ColorConstants.primaryColor,
    ),
  ),
  unselectedWidgetColor: ColorConstants.primaryColor,
  primaryColor: ColorConstants.primaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
    selectedItemColor: ColorConstants.primaryColor,
    unselectedItemColor: Colors.grey,
  ),
);
