import 'package:flutter/cupertino.dart';
import 'package:calm_addict_flutter/ui/home/widgets/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Riverpod MVVM Demo',
      theme: const CupertinoThemeData(),
      home: const HomeScreen(title: 'Home'),
    );
  }
}