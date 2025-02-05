// user_model.dart
class UserModel {
  final String firebaseId;
  final int meditationLevel;

  UserModel({
    required this.firebaseId,
    required this.meditationLevel,
  });

  /// Creates a UserModel from a map. The keys should match your Supabase column names.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firebaseId: map['firebase_id'] as String,
      meditationLevel: map['meditation_level'] as int,
    );
  }

  /// Converts the UserModel to a map for Supabase.
  Map<String, dynamic> toMap() {
    return {
      'firebase_id': firebaseId,
      'meditation_level': meditationLevel,
    };
  }
}
