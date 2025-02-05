import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


/// The SecondPage widget that you navigate to from HomePage.
class MeditationPlayer extends StatelessWidget {
  const MeditationPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meditation Player'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go Back'),
          onPressed: () {
            // Pop the current route to return to the previous page.
            context.pop();
          },
        ),
      ),
    );
  }
}