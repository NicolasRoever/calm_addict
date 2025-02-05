import 'package:go_router/go_router.dart';
import 'package:calm_addict_flutter/routing/routes.dart';
import 'package:calm_addict_flutter/ui/home/widgets/home_screen.dart';
import 'package:calm_addict_flutter/ui/login/login_page.dart';
import 'package:calm_addict_flutter/ui/meditation_player/view/meditation_player.dart';
import 'package:calm_addict_flutter/ui/profile_screen/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';




final router = GoRouter(
initialLocation: Routes.home,
redirect: (BuildContext context, GoRouterState state) {
  final bool signedIn = FirebaseAuth.instance.currentUser != null;
  
  // Allow initial access to home screen
  if (state.uri.path == Routes.home && state.uri.path == state.matchedLocation) {
    return null;  // Don't redirect
  }
  
  // For all other routes, enforce authentication
  if (!signedIn) {
    return Routes.login;
  }
  return null;  // No redirect needed if signed in
},

  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomeScreen(title: 'Home'),
    ),
    GoRoute(
      path: Routes.meditationPlayer,
      builder: (context, state) => MeditationPlayer(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: Routes.profile,
      builder: (context, state) => const ProfilePage(),
    ),
  ],


);