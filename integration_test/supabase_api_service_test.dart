// integration_test/supabase_api_service_test.dart
// import 'package:flutter_test/flutter_test.dart';
// import 'package:supabase/supabase.dart';
// import 'package:calm_addict_flutter/data/services/api/supabase_api_service.dart';
// import 'package:calm_addict_flutter/domain/models/user_model.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// void main() {
//   // Grouping the integration tests related to the SupabaseApiService.
//   group('SupabaseApiService Integration Tests', () {
//     // Create variables for the client and the API service.
//     late SupabaseClient client;
//     late SupabaseApiService apiService;

//     // This runs before all tests in the group.
//     setUpAll(() async {
//       // Load the environment variables
//       await dotenv.load(fileName: '.env');

//       print('SUPABASE_URL: ${dotenv.env['SUPABASE_URL']}');
      
//       // Get values from .env file with null checks
//       final supabaseUrl = dotenv.env['SUPABASE_URL']!;
//       final supabaseKey = dotenv.env['SUPABASE_KEY']!;
      
//       // Initialize the Supabase client
//       client = SupabaseClient(supabaseUrl, supabaseKey);
      
//       // Initialize your API service with the client.
//       apiService = SupabaseApiService(client: client);
//     });

//     test('Retrieve user with id number "1"', () async {
//       // Call the getUser method passing "1" as the firebaseId.
//       final UserModel? user = await apiService.getUser('testfirebaseid');

//       // Optionally, verify some properties of the user.
//       // This assumes that your UserModel has a property called 'firebaseId' or similar.
//       expect(user!.meditationLevel, equals(1));
      
//       // You can add more checks here based on the properties you expect.
//       // For example:
//       // expect(user.name, isNotEmpty);
//       // expect(user.email, contains('@'));
//     });
//   });
// }
