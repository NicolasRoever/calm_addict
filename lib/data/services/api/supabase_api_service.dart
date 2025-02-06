// supabase_api_service.dart
import 'package:supabase/supabase.dart';
import 'package:calm_addict_flutter/domain/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:calm_addict_flutter/domain/models/user_model.dart';

class SupabaseApiService {
  final SupabaseClient client;

  SupabaseApiService({required this.client});

  /// Retrieves the user from Supabase using the Firebase ID.
  Future<UserModel?> getUser(String firebaseId) async {
    try {
      // First, let's get all records to see what's in the database
      print("Getting all records from UserTable");
      final allRecords = await client
        .from('UserTable')
        .select();
      
      print("All records in UserTable:");
      print(allRecords);
      
      // Now proceed with the original query
      final data = await client
        .from('UserTable')
        .select()
        //.eq('user_id_firebase', firebaseId)
        .maybeSingle();

      print("Retrieved specific user: $data");

      if (data == null) {
        return null;
      }
      return UserModel.fromMap(data);

    } on PostgrestException catch (error) {
        print('Error querying database: ${error.message}');
        print('Error details: ${error.details}');
        return null; 
    }
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


  void testConnection() async {
  try {
    print('Querying UserTable...');
    final result = await client
        .from('"UserTable"')  // or use 'usertable' based on your actual table name.
        .select('*');
    print('Data received: $result');
  } on PostgrestException catch (error) {
    print('PostgrestException caught: ${error.message}');
    print('Error details: ${error.details}');
  } catch (e, stackTrace) {
    print('General exception caught: $e');
    print('Stack trace: $stackTrace');
  }
}


}
