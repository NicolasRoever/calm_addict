// test/firebase_api_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:calm_addict_flutter/data/services/api/firebase_api_service.dart'; // Adjust the import to your project structure

void main() {
  group('FirebaseApiService', () {
    test('getFirebaseId returns user uid if signed in', () async {
      // Create a mock user with a known UID.
      final mockUser = MockUser(
        isAnonymous: false,
        uid: '5xVgUikKthPWivMLqHwE1xCPsbQ2',
        email: 'nicoroever@gmail.com',
      );
      // Create a mock FirebaseAuth instance
      final mockAuth = MockFirebaseAuth(mockUser: mockUser);

      // force a sign-in if needed:
      await mockAuth.signInWithEmailAndPassword(
        email: 'nicoroever@gmail.com',
        password: 'HoeningerWeg7!',
      );

      // Inject the mock FirebaseAuth into the service.
      final service = FirebaseApiService(auth: mockAuth);

      final firebaseId = await service.getFirebaseId();

      expect(firebaseId, equals('5xVgUikKthPWivMLqHwE1xCPsbQ2'));
    });

    test('getFirebaseId returns null if no user is signed in', () async {
      // Create a mock FirebaseAuth instance with no signed-in user.
      final mockAuth = MockFirebaseAuth(signedIn: false);

      // Inject the mock FirebaseAuth into the service.
      final service = FirebaseApiService(auth: mockAuth);

      final firebaseId = await service.getFirebaseId();

      expect(firebaseId, isNull);
    });
  });
}
