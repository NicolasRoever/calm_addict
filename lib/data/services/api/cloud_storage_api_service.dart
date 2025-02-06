import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';

class MeditationStorageService {
  final FirebaseStorage storage;

  MeditationStorageService({FirebaseStorage? storage})
      : storage = storage ?? FirebaseStorage.instance;

  /// Retrieves the audio file data for a meditation file stored in Firebase Storage.
  ///
  /// The [firebaseStorageUrl] should be in the format:
  ///   gs://calmaddict-123.firebasestorage.app/BoxBreathingCourse/BoxBreathing_1.MP3
  ///
  /// [maxSize] specifies the maximum number of bytes to download. The default is 10MB.
  /// Returns the file's bytes as [Uint8List] if successful.
  Future<Uint8List?> getMeditationFile(String firebaseStorageUrl, {int maxSize = 10 * 1024 * 1024}) async {
    try {
      // Create a reference from the Firebase Storage URL.
      final ref = storage.refFromURL(firebaseStorageUrl);

      // Retrieve the file data as bytes.
      final Uint8List? fileData = await ref.getData(maxSize);
      return fileData;
    } catch (e) {
      print('Error retrieving meditation file: $e');
      rethrow;
    }
  }
}
