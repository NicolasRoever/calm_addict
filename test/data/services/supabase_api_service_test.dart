// test/api_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:supabase/supabase.dart';
import 'package:calm_addict_flutter/data/services/api/supabase_api_service.dart';
import 'package:calm_addict_flutter/domain/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:calm_addict_flutter/domain/models/meditation_model.dart';
void main() {
  group('SupabaseApiService.getUser Tests', () {
    // Declare variables that will be initialized later.
    late SupabaseClient client;
    late SupabaseApiService apiService;

    setUpAll(() async {

      // Load the environment variables.
      await dotenv.load(fileName: '.env');

      // Now that the env variables are loaded, retrieve them.
      final supabaseUrl = dotenv.env['SUPABASE_URL']!;
      final supabaseKey = dotenv.env['SUPABASE_ANON_KEY']!;

      // Create the Supabase client and the API service.
      client = SupabaseClient(supabaseUrl, supabaseKey);
      apiService = SupabaseApiService(client: client);
    });

    test(
      'Retrieve user with firebaseId "testfirebaseid" and meditationLevel is 1',
      () async {
        // Call the API service method to get the user.
        final UserModel? user = await apiService.getUser("testfirebaseid");

        // Verify that the user is not null.
        expect(user, isNotNull,
            reason: 'User with firebaseId "testfirebaseid" should exist.');

        // Optionally print the user details for debugging.
        print("Retrieved user: ${user!.toString()}");

        // Verify that the user's meditation level is 1.
        expect(user.meditationLevel, equals(1),
            reason: 'The user\'s meditationLevel should be 1.');
      },
    );

    test('Retrieve meditation data with meditationId 1', () async {
      // Call the API service method to get the meditation data.
      print('Retrieving meditation data with meditationId 1');
      final MeditationModel? meditation = await apiService.getMeditationData(meditationId: 1);

      print('Retrieved meditation: ${meditation?.toString()}');

      // Verify that the meditation data is not null.
      expect(meditation?.id, equals(1));
    });
  });
}
