import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/features/profile/views/profile_screen.dart';
import 'package:tuti/features/tutis/views/home_screen.dart';
import 'package:tuti/features/tutis/views/tuti_screen.dart';

import 'features/auth/views/join_private_screen.dart';
import 'features/auth/views/join_screen.dart';
import 'features/auth/views/login_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: TuTiScreen.routePath,
    redirect: (context, state) async {
      // if (kIsWeb) {
      //   return null;
      // }
      // const storage = FlutterSecureStorage();
      // final accessToken = await storage.read(key: 'accessToken');
      // if (accessToken == null) {
      // if (state.subloc != JoinPrivateScreen.routePath &&
      //     state.subloc != JoinScreen.routePath &&
      //     state.subloc != LoginScreen.routePath &&
      //     state.subloc != HomeScreen.routePath) {
      //   return HomeScreen.routePath;
      // }
      // }
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
      GoRoute(
          name: JoinScreen.routeName,
          path: JoinScreen.routePath,
          builder: (context, state) => const JoinScreen()),
      GoRoute(
          name: JoinPrivateScreen.routeName,
          path: JoinPrivateScreen.routePath,
          builder: (context, state) => const JoinPrivateScreen()),
      GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routePath,
          builder: (context, state) => const LoginScreen()),
    ],
  );
});
