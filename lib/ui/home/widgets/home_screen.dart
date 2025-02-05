import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart'; // Import material.dart
import 'package:go_router/go_router.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hi!',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.push('/meditation-player');
              },
              child: const Text('Go to Meditation Player'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.push('/profile');
              },
              child: const Text('Go to Profile'),
            ),
          ], 
        ),
      ),
    );
  }
}
