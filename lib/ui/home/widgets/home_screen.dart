import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:calm_addict_flutter/providers/providers.dart'; // Make sure this path is correct.

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve the repository from the provider.
    final userRepository = ref.read(userRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: SingleChildScrollView(
          // In case the content overflows.
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Call getUser() from the repository.
                  final user = await userRepository.getUser();
                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User: ${user.toString()}')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No user found')),
                    );
                  }
                },
                child: const Text('Get User'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Call updateUserMeditationLevel with a value of 2.
                  final success =
                      await userRepository.updateUserMeditationLevel(2);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success
                          ? 'Meditation level updated'
                          : 'Failed to update meditation level'),
                    ),
                  );
                },
                child: const Text('Update Meditation Level to 2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
