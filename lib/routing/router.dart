import 'package:go_router/go_router.dart';
import 'package:calm_addict_flutter/routing/routes.dart';
import 'package:calm_addict_flutter/ui/home/widgets/home_screen.dart';
import 'package:calm_addict_flutter/ui/meditation_player/view/meditation_player.dart';


final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomeScreen(title: 'Home'),
    ),
    GoRoute(
      path: Routes.meditationPlayer,
      builder: (context, state) => MeditationPlayer(),
    ),
  ],
);