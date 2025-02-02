import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calm_addict_flutter/ui/core/themes/theme.dart';
import 'package:calm_addict_flutter/routing/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Riverpod MVVM Demo',
      theme: AppTheme.theme,
      routerConfig: router, // Use the router from the external file
    );
  }
}


