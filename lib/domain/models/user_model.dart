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
      firebaseId: map['user_id_firebase'] as String,
      meditationLevel: map['user_level'] as int,
    );
  }

  /// Converts the UserModel to a map for Supabase.
  Map<String, dynamic> toMap() {
    return {
      'user_id_firebase': firebaseId,
      'user_level': meditationLevel,
    };
  }
}
