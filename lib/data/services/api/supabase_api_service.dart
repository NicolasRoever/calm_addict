// supabase_api_service.dart
import 'package:supabase/supabase.dart';
import 'package:calm_addict_flutter/domain/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:calm_addict_flutter/domain/models/meditation_model.dart';

class SupabaseApiService {
  final SupabaseClient client;

  SupabaseApiService({required this.client});

  /// Retrieves the user from Supabase using the Firebase ID.
  Future<UserModel?> getUser(String firebaseId) async {
    try {
      // Now proceed with the original query
      final data = await client
        .from('UserTable')
        .select()
        .eq('user_id_firebase', firebaseId)
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
        .update({'user_level': newMeditationLevel})
        .eq('user_id_firebase', firebaseId);

    if (response.error != null) {
      print('Error updating user: ${response.error!.message}');
      return false;
    }
    return true;
  }


  // Get  meditation data from Supabase
  Future<MeditationModel?> getMeditationData({
    String? meditationId,
    int? meditationLevel,
    String? courseName,
    int? levelInCourse,
  }) async {
    try {
      // Start building the query on your MeditationTable.
      var query = client.from('MeditationsTable').select();

      // Determine which filter(s) to apply.
      if (meditationId != null) {
        query = query.eq('meditation_id', meditationId);
      } else if (courseName != null && levelInCourse != null) {
        query = query.eq('course_name', courseName).eq('level_in_course', levelInCourse);
      } else if (meditationLevel != null) {
        query = query.eq('meditation_level', meditationLevel);
      } else {
        throw Exception('No valid criteria provided to retrieve meditation.');
      }

      // Retrieve a single record (or null if none match).
      final data = await query.maybeSingle();
      if (data == null) {
        return null;
      }
      // Convert the returned map to a MeditationModel.
      return MeditationModel.fromMap(data);
    } on PostgrestException catch (error) {
      print('Error retrieving meditation: ${error.message}');
      print('Error details: ${error.details}');
      return null;
    }
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
