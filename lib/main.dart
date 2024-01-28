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

  const nativeAppKey = '4b00f616a81b54e28b1ec7f62cc4ca62';
  KakaoSdk.init(nativeAppKey: nativeAppKey);

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
        child: MaterialApp.router(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.1),
              ),
              child: child!,
            );
          },
          title: StringConstants.appName,
          routerConfig: ref.watch(routerProvider),
          themeMode: ThemeMode.light,
          theme: ThemeData(
            unselectedWidgetColor: ColorConstants.primaryColor,
            primaryColor: ColorConstants.primaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Gothic A1',
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              elevation: 0,
              selectedItemColor: ColorConstants.primaryColor,
              unselectedItemColor: Colors.grey,
            ),
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
