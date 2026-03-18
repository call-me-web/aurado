import 'package:equatable/equatable.dart';

/// Defines the global user roles within the Aurado ecosystem.
enum UserRole {
  /// Platform agents (Admins, Editors, Monitors).
  agent,
  /// Standard learners/students.
  student;

  /// Helper to parse role from string.
  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => UserRole.student,
    );
  }
}

/// Represents a unified user profile within the application.
/// 
/// Combines data from Supabase Auth and the public.profiles table.
class UserModel extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  final UserRole role;
  final bool isStudentActive;
  /// Specific to the 'students' table / context.
  final String? educationLevel;
  final String? languagePreference;
  final String? country;
  final int streakCount;

  const UserModel({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.avatarUrl,
    this.role = UserRole.student,
    this.isStudentActive = true,
    this.educationLevel,
    this.languagePreference,
    this.country,
    this.streakCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        avatarUrl,
        role,
        isStudentActive,
        educationLevel,
        languagePreference,
        country,
        streakCount,
      ];

  /// Factory to create a UserModel from Supabase metadata and Profile data.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      avatarUrl: map['avatar_url'] as String?,
      role: UserRole.fromString(map['role'] as String? ?? 'student'),
      isStudentActive: map['is_student_active'] as bool? ?? true,
      educationLevel: map['education_level'] as String?,
      languagePreference: map['language_preference'] as String?,
      country: map['country'] as String?,
      streakCount: map['streak_count'] as int? ?? 0,
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    UserRole? role,
    bool? isStudentActive,
    String? educationLevel,
    String? languagePreference,
    String? country,
    int? streakCount,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      isStudentActive: isStudentActive ?? this.isStudentActive,
      educationLevel: educationLevel ?? this.educationLevel,
      languagePreference: languagePreference ?? this.languagePreference,
      country: country ?? this.country,
      streakCount: streakCount ?? this.streakCount,
    );
  }
}
