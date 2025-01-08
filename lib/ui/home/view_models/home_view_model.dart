import 'package:flutter_riverpod/flutter_riverpod.dart';

// A StateNotifier to manage the counter state
class CounterViewModel extends StateNotifier<int> {
  CounterViewModel() : super(0); // Initialize the counter at 0

  // Method to increment the counter
  void incrementCounter() {
    state++;
  }
}

// The provider that exposes CounterViewModel
final counterProvider = StateNotifierProvider<CounterViewModel, int>(
  (ref) => CounterViewModel(),
);