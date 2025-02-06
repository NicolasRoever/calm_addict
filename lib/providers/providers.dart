// lib/providers/providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calm_addict_flutter/data/services/api/firebase_api_service.dart';
import 'package:calm_addict_flutter/data/services/api/supabase_api_service.dart';
import 'package:calm_addict_flutter/data/repositories/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:calm_addict_flutter/data/repositories/meditation_repository.dart';
import 'package:calm_addict_flutter/data/services/api/cloud_storage_api_service.dart';

/// Provider for FirebaseApiService.
/// This could be a [Provider] since FirebaseAuth is usually a singleton.
final firebaseApiServiceProvider = Provider<FirebaseApiService>((ref) {
  return FirebaseApiService();
});

/// Provider for SupabaseApiService.
/// Note: Make sure Supabase is initialized before this provider is used.
final supabaseApiServiceProvider = Provider<SupabaseApiService>((ref) {
  // Supabase.instance.client is assumed to be ready.
  return SupabaseApiService(client: Supabase.instance.client);
});

// Provider for rthe cloud storage API service
final meditationStorageServiceProvider = Provider<MeditationStorageService>((ref) {
  return MeditationStorageService();
});

/// Provider for UserRepository which depends on the two services above.
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final firebaseService = ref.read(firebaseApiServiceProvider);
  final supabaseService = ref.read(supabaseApiServiceProvider);
  return UserRepository(
    firebaseApiService: firebaseService,
    supabaseApiService: supabaseService,
  );
});


/// Provider for MeditationRepository which depends on the two services above.
final meditationRepositoryProvider = Provider<MeditationRepository>((ref) {
  final supabaseService = ref.read(supabaseApiServiceProvider);
  final storageService = ref.read(meditationStorageServiceProvider);
  return MeditationRepository(dbService: supabaseService, storageService: storageService);
});
