// user_repository.dart
import 'package:calm_addict_flutter/data/services/api/firebase_api_service.dart';
import 'package:calm_addict_flutter/data/services/api/supabase_api_service.dart';
import 'package:calm_addict_flutter/domain/models/user_model.dart';

class UserRepository {
  final FirebaseApiService firebaseApiService;
  final SupabaseApiService supabaseApiService;

  UserRepository({
    required this.firebaseApiService,
    required this.supabaseApiService,
  });

  /// Retrieves the user by first obtaining the Firebase ID and then querying Supabase.
  Future<UserModel?> getUser() async {
    // Retrieve the current Firebase user ID.
    final firebaseId = await firebaseApiService.getFirebaseId();
    if (firebaseId == null) {
      print('No Firebase user found.');
      return null;
    }
    // Use the Firebase ID to query the Supabase database.
    return await supabaseApiService.getUser(firebaseId);
  }

  /// Updates the user's meditation level by first obtaining the Firebase ID.
  Future<bool> updateUserMeditationLevel(int newMeditationLevel) async {
    // Retrieve the current Firebase user ID.
    final firebaseId = await firebaseApiService.getFirebaseId();
    if (firebaseId == null) {
      print('No Firebase user found.');
      return false;
    }
    // Update the user's meditation level in Supabase.
    return await supabaseApiService.updateUserMeditationLevel(firebaseId, newMeditationLevel);
  }
}
