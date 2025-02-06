// lib/data/repositories/meditation_repository.dart

import 'package:calm_addict_flutter/data/services/api/supabase_api_service.dart';
import 'package:calm_addict_flutter/data/services/api/cloud_storage_api_service.dart';
import 'package:calm_addict_flutter/domain/models/meditation_model.dart';
import 'dart:typed_data';

class MeditationRepository {
  final SupabaseApiService dbService;
  final MeditationStorageService storageService;

  MeditationRepository({
    required this.dbService,
    required this.storageService,
  });

  /// Retrieves a single meditation based on one or more criteria.
  /// At least one criterion must be provided.
  Future<MeditationModel?> getMeditationData({
    String? meditationId,
    int? meditationLevel,
    String? courseName,
    int? levelInCourse,
  }) async {
    return await dbService.getMeditationData(
      meditationId: meditationId,
      meditationLevel: meditationLevel,
      courseName: courseName,
      levelInCourse: levelInCourse,
    );
  }

  // Retrieves the audio file for the meditation.
  /// The method first retrieves the meditation metadata from Supabase and
  /// then uses the storage service to download the audio file from Firebase Storage.
  Future<Uint8List?> getMeditationAudioFile({
    String? meditationId,
    int? meditationLevel,
    String? courseName,
    int? levelInCourse,
  }) async {
    // Retrieve the meditation metadata from Supabase.
    final meditation = await getMeditationData(
      meditationId: meditationId,
      meditationLevel: meditationLevel,
      courseName: courseName,
      levelInCourse: levelInCourse,
    );

    if (meditation == null) return null;

    // Use the file URL stored in the metadata.
    final firebaseStorageUrl = meditation.fileUrl;

    // Download the audio file from Firebase Storage.
    return await storageService.getMeditationFile(firebaseStorageUrl);
  }
}
