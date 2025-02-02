import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart'; // Import material.dart
import 'package:calm_addict_flutter/ui/home/view_models/home_view_model.dart';
import 'package:go_router/go_router.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the current counter value
    final counter = ref.watch(counterProvider);

    // Access the ViewModel to call methods
    final viewModel = ref.read(counterProvider.notifier);

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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter', // Displays the current counter value
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: viewModel.incrementCounter, // Call ViewModel logic
              child: const Text('Increment'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/meditation-player');
              },
              child: const Text('Go to Meditation Player'),
            ),
          ],
        ),
      ),
    );
  }
}
