// supabase_api_service_test.dart
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase/supabase.dart';
import 'package:calm_addict_flutter/domain/models/user_model.dart';
import 'package:calm_addict_flutter/data/services/api/supabase_api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // Ensure the Flutter test binding is initialized.
  TestWidgetsFlutterBinding.ensureInitialized();

  // Debug: print the current directory.
  print('Current directory: ${Directory.current.path}');

  // Build an absolute path to the .env file.
  final envPath = '${Directory.current.path}/.env';
  print('Looking for .env file in: ${Directory.current.path}');
  print('File exists: ${File(envPath).existsSync()}');

  // Load the .env file.
  await dotenv.load(fileName: envPath);
  print('Dotenv loaded successfully.');

  group('SupabaseApiService Integration Test', () {
    late SupabaseApiService supabaseApiService;
    // Known test Firebase ID.
    const firebaseId = '5xVgUikKthPWivMLqHwE1xCPsbQ2';

    setUpAll(() {
      // Retrieve the credentials from dotenv AFTER it has been loaded.
      final supabaseUrl = dotenv.env['SUPABASE_URL']!;
      final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;

      // Initialize the Supabase client.
      final client = SupabaseClient(supabaseUrl, supabaseAnonKey);

      // Create an instance of SupabaseApiService.
      supabaseApiService = SupabaseApiService(client: client);
    });

    test('Retrieve user and update meditation level without side effects', () async {
      // 1. Retrieve the user.
      final userBefore = await supabaseApiService.getUser(firebaseId);
      expect(userBefore, isNotNull, reason: 'User must exist in the database.');

      // 2. Update the meditation level to 2.
      final updateSuccess = await supabaseApiService.updateUserMeditationLevel(firebaseId, 2);
      expect(updateSuccess, isTrue, reason: 'The update to level 2 should succeed.');

      // 3. Retrieve the user again to verify the update.
      final userAfterUpdate = await supabaseApiService.getUser(firebaseId);
      expect(userAfterUpdate!.meditationLevel, equals(2), reason: 'Meditation level should be updated to 2.');

      // 4. Revert the meditation level back to 1.
      final revertSuccess = await supabaseApiService.updateUserMeditationLevel(firebaseId, 1);
      expect(revertSuccess, isTrue, reason: 'Reverting the update should succeed.');
    });
  });
}
