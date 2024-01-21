import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/features/profile/views/profile_screen.dart';
import 'package:tuti/features/tutis/views/home_screen.dart';
import 'package:tuti/features/tutis/views/tuti_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: TuTiScreen.routePath,
    redirect: (context, state) async {
      return null;
    },
    routes: [
      GoRoute(
          name: HomeScreen.routeName,
          path: HomeScreen.routePath,
          builder: (context, state) => const HomeScreen()),
      GoRoute(
          name: TuTiScreen.routeName,
          path: TuTiScreen.routePath,
          builder: (context, state) => const TuTiScreen()),
      GoRoute(
          name: ProfileScreen.routeName,
          path: ProfileScreen.routePath,
          builder: (context, state) => const ProfileScreen()),
    ],
  );
});
