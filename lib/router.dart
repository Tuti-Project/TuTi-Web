import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:tuti/features/tutis/views/home_screen.dart';
import 'package:tuti/features/tutis/views/tuti_screen.dart';

import 'common/main_navigation_screen.dart';
import 'features/auth/views/join_private_screen.dart';
import 'features/auth/views/join_screen.dart';
import 'features/auth/views/login_screen.dart';
import 'features/profile/views/edit_profile_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: TuTiScreen.routePath,
    redirect: (context, state) async {
      if (kIsWeb) {
        return null;
      }
      const storage = FlutterSecureStorage();
      final accessToken = await storage.read(key: 'accessToken');
      if (accessToken == null) {
        Logger().i('accessToken: ${accessToken == null}');
        if (state.subloc != JoinPrivateScreen.routePath &&
            state.subloc != JoinScreen.routePath &&
            state.subloc != LoginScreen.routePath &&
            state.subloc != HomeScreen.routePath) {
          return HomeScreen.routePath;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
          name: HomeScreen.routeName,
          path: HomeScreen.routePath,
          builder: (context, state) => const HomeScreen()),
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
      GoRoute(
        name: MainNavigationScreen.routeName,
        path: "/:tab(personalBranding|tuti|profile)",
        builder: (context, state) {
          final tab = state.params["tab"] ?? "tuti";
          return MainNavigationScreen(tab: tab);
        },
        routes: [
          GoRoute(
            name: EditProfileScreen.routeName,
            path: EditProfileScreen.routePath,
            builder: (context, state) => const EditProfileScreen(),
          ),
        ],
      ),
    ],
  );
});
