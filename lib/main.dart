import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calm_addict_flutter/ui/core/themes/theme.dart';
import 'package:calm_addict_flutter/routing/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:calm_addict_flutter/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

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


