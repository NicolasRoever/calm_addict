
class MeditationModel {
  final int id;
  final int meditationLevel;
  final String courseName;
  final String meditationUrl; // URL stored in the DB
  final int levelInCourse;
  
  MeditationModel({
    required this.id,
    required this.meditationLevel,
    required this.courseName,
    required this.meditationUrl,
    required this.levelInCourse,
  });

  factory MeditationModel.fromMap(Map<String, dynamic> map) {
    return MeditationModel(
      id: map['meditation_id'] as int,
      meditationLevel: map['meditation_level'] as int,
      courseName: map['course_name'] as String,
      meditationUrl: map['meditation_url'] as String,
      levelInCourse: map['level_in_course'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'meditation_id': id,
      'meditation_level': meditationLevel,
      'course_name': courseName,
      'meditation_url': meditationUrl,
      'level_in_course': levelInCourse,
    };
  }
}
