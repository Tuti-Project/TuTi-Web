import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuti/common/constraints_scaffold.dart';
import 'package:tuti/features/tutis/widgets/home_widgets/content_widget.dart';
import 'package:tuti/features/tutis/widgets/home_widgets/footer_widget.dart';

class HomeScreen extends ConsumerWidget {
  static const String routeName = "home";
  static const String routePath = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ConstraintsScaffold(
      child: Column(
        children: [
          ContentWidget(),
          Spacer(),
          FooterWidget(),
        ],
      ),
    );
  }
}
