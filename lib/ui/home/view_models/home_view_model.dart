import 'package:riverpod_annotation/riverpod_annotation.dart';

// This line is needed for code generation
part 'home_view_model.g.dart';

@riverpod
class Counter extends _$Counter {
  @override
  int build() {
    return 0; // Initialize the counter at 0
  }

  // Method to increment the counter
  void incrementCounter() {
    state++;
  }
}





