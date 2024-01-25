import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/constants/string.dart';
import 'package:tuti/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return SafeArea(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp.router(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.1),),
              child: child!,
            );
          },
          title: StringConstants.appName,
          routerConfig: ref.watch(routerProvider),
          themeMode: ThemeMode.light,
          theme: ThemeData(
            fontFamily: 'Gothic A1',
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
