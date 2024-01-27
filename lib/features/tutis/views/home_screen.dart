import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/features/tutis/widgets/home_widgets/content_widget.dart';
import 'package:tuti/features/tutis/widgets/home_widgets/footer_widget.dart';

class HomeScreen extends ConsumerWidget {
  static const String routeName = "home";
  static const String routePath = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const background = 'assets/images/home_mobile.jpg';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              background,
            ),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: const Column(
          children: [
            ContentWidget(),
            Spacer(),
            FooterWidget(),
          ],
        ),
      ),
    );
  }
}
