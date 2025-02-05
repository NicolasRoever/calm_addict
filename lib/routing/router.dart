import 'package:go_router/go_router.dart';
import 'package:calm_addict_flutter/routing/routes.dart';
import 'package:calm_addict_flutter/ui/home/widgets/home_screen.dart';
import 'package:calm_addict_flutter/ui/login/login_page.dart';
import 'package:calm_addict_flutter/ui/meditation_player/view/meditation_player.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';




final router = GoRouter(
redirect: (BuildContext context, GoRouterState state) {
  final bool signedIn = FirebaseAuth.instance.currentUser != null;
  if (!signedIn) {
    return Routes.login;
  }
  return null;
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
  ],


);