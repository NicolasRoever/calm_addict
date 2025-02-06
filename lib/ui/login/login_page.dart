import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:calm_addict_flutter/routing/routes.dart';
import 'package:go_router/go_router.dart';



class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      // Specify the authentication providers you want to support.
      providers: [
        EmailAuthProvider(),
        // You can add other providers here if needed.
      ],
      // Actions allow you to react to authentication state changes.
      actions: [
        // When the user successfully signs in, navigate to the home page.
        AuthStateChangeAction<SignedIn>((context, state) {
          // Replace the current page with the home page.
          context.push(Routes.home);
        }),
      ],
      // Optionally, you can customize the header and footer.
      headerBuilder: (context, constraints, _) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Welcome to Calm Addict',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );
      },
      footerBuilder: (context, _) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'By signing in, you agree to our Terms of Service and Privacy Policy.',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
