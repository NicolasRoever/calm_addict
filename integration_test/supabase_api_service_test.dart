// integration_test/supabase_integration_test.dart

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async {
  // Initialize the integration test binding.
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Set mock initial values for SharedPreferences to avoid MissingPluginException.
  SharedPreferences.setMockInitialValues({});

  // Load your environment variables (adjust the path to your .env file if needed).
  final envPath = '${Directory.current.path}/.env';
  await dotenv.load(fileName: envPath);

  // Initialize Supabase with your project credentials.
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  testWidgets('Print all users in UserTable', (WidgetTester tester) async {
    // Access the initialized Supabase client.
    final supabase = Supabase.instance.client;
    
    // Perform the query on the "UserTable".
    final response = await supabase.from('UserTable').select();
    
    // Print the response.
    print(response);
  });
}


// group('SupabaseApiService Integration Test', () {
//     late SupabaseApiService supabaseApiService;
//     // Known test Firebase ID.
//     const firebaseId = '5xVgUikKthPWivMLqHwE1xCPsbQ2';

//     setUpAll(() {
//       // Retrieve the credentials from dotenv AFTER it has been loaded.
//       final supabaseUrl = dotenv.env['SUPABASE_URL']!;
//       final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;

//       // Initialize the Supabase client.
//       final client = SupabaseClient(supabaseUrl, supabaseAnonKey);

//       // Create an instance of SupabaseApiService.
//       supabaseApiService = SupabaseApiService(client: client);
//     });

//     test('Retrieve user and update meditation level without side effects', () async {
  
//       // 1. Retrieve the user.
//       supabaseApiService.testConnection();
//       print("Runngin first test for user: $firebaseId");
//       final userBefore = await supabaseApiService.getUser(firebaseId);
//       expect(userBefore, isNotNull, reason: 'User must exist in the database.');

//       // 2. Update the meditation level to 2.
//       final updateSuccess = await supabaseApiService.updateUserMeditationLevel(firebaseId, 2);
//       expect(updateSuccess, isTrue, reason: 'The update to level 2 should succeed.');

//       // 3. Retrieve the user again to verify the update.
//       final userAfterUpdate = await supabaseApiService.getUser(firebaseId);
//       expect(userAfterUpdate!.meditationLevel, equals(2), reason: 'Meditation level should be updated to 2.');

//       // 4. Revert the meditation level back to 1.
//       final revertSuccess = await supabaseApiService.updateUserMeditationLevel(firebaseId, 1);
//       expect(revertSuccess, isTrue, reason: 'Reverting the update should succeed.');
//     });
//   });