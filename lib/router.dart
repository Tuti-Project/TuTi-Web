import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/common/flutter_security_storage_manager.dart';
import 'package:tuti/features/tutis/views/home_screen.dart';
import 'package:tuti/features/tutis/views/tuti_screen.dart';

import 'common/main_navigation_screen.dart';
import 'common/token_manager.dart';
import 'features/auth/views/join_private_screen.dart';
import 'features/auth/views/join_screen.dart';
import 'features/auth/views/login_screen.dart';
import 'features/profile/views/edit_profile_screen.dart';
import 'features/tutis/views/tuti_detail_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: TuTiScreen.routePath,
    redirect: (context, state) async {
      if (kIsWeb) {
        String? authToken = await TokenManager.getToken();
        if (authToken == null || authToken.isEmpty) {
          if (state.subloc != JoinPrivateScreen.routePath &&
              state.subloc != JoinScreen.routePath &&
              state.subloc != LoginScreen.routePath &&
              state.subloc != HomeScreen.routePath) {
            return HomeScreen.routePath;
          }
        }
        return null;
      } else {
        String? authToken = await FlutterSecureStorageManager.getStorage();
        if (authToken == null || authToken.isEmpty) {
          if (state.subloc != JoinPrivateScreen.routePath &&
              state.subloc != JoinScreen.routePath &&
              state.subloc != LoginScreen.routePath &&
              state.subloc != HomeScreen.routePath) {
            return HomeScreen.routePath;
          }
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
            builder: (context, state) {
              return const EditProfileScreen();
            },
          ),
          GoRoute(
            name: TuTiDetailScreen.routeName,
            path: TuTiDetailScreen.routePath,
            builder: (context, state) {
              final memberId = int.parse(state.queryParams["memberId"] ?? "0");
              return TuTiDetailScreen(memberId: memberId);
            },
          ),
        ],
      ),
    ],
  );
});
