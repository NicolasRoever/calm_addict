// lib/ui/profile/profile_screen.dart
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ProfileScreen(
        // Customize actions: for example, when a user signs out, pop the profile route.
        actions: [
          SignedOutAction((context) {
            // When the user signs out, navigate back or to a different route as needed.
            context.pop();
          })
        ],
      ),
    );
  }
}
