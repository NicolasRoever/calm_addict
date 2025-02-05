// supabase_api_service.dart
import 'package:supabase/supabase.dart';
import 'package:calm_addict_flutter/domain/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseApiService {
  final SupabaseClient client;

  SupabaseApiService({required this.client});

  /// Retrieves the user from Supabase using the Firebase ID.
  Future<UserModel?> getUser(String firebaseId) async {
    try {
      final data = await client
        .from('UserTable') // Ensure this matches your Supabase table name.
        .select()
        .eq('user_id_firebase', firebaseId)
        .maybeSingle();

    } on PostgrestException catch (error) {
        print('Error updating user: ${error.message}');
        print('Error details: ${error.details}');
        return null; 
    }

    

    return UserModel.fromMap(data as Map<String, dynamic>);
  }

  /// Updates the user's meditation level in Supabase.
  Future<bool> updateUserMeditationLevel(String firebaseId, int newMeditationLevel) async {
    final response = await client
        .from('UserTable')
        .update({'meditation_level': newMeditationLevel})
        .eq('user_id_firebase', firebaseId);

    if (response.error != null) {
      print('Error updating user: ${response.error!.message}');
      return false;
    }
    return true;
  }
}
