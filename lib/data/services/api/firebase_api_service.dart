// firebase_api_service.dart
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseApiService {
  final FirebaseAuth _auth;

  FirebaseApiService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  /// Retrieves the Firebase ID of the currently authenticated user.
  Future<String?> getFirebaseId() async {
    final user = _auth.currentUser;
    return user?.uid;
  }
}
