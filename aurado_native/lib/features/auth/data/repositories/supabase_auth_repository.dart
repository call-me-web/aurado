import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:aurado/features/auth/domain/models/user_model.dart';
import 'package:aurado/features/auth/domain/repositories/auth_repository.dart';

/// Supabase implementation of Authentication.
/// 
/// Manages the orchestration of Supabase Auth with public.profiles and public.students.
class SupabaseAuthRepository implements AuthRepository {
  final supabase.SupabaseClient _client;

  SupabaseAuthRepository(this._client);

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      // 1. Sign up in Supabase Auth
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': name,
          'phone': phone,
        },
      );

      if (response.user == null) {
        throw Exception('Sign up failed: User is null');
      }

      final userId = response.user!.id;

      // 2. Ensure Student record exists with retry-backoff.
      // A missing student record will silently break all student-specific features,
      // so we surface the failure if all retries are exhausted.
      await _upsertStudentRecord(userId);

      return _mapToUserModel(response.user!, {
        'name': name,
        'email': email,
        'phone': phone,
        'role': 'student',
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Upserts the student record with up to [maxAttempts] retries.
  ///
  /// Throws if all attempts fail, so sign-up can surface the failure
  /// rather than silently creating an incomplete account.
  Future<void> _upsertStudentRecord(
    String userId, {
    int maxAttempts = 3,
  }) async {
    const baseDelay = Duration(milliseconds: 500);

    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        await _client.from('students').upsert({
          'id': userId,
          'education_level': null,
          'language_preference': 'bn',
          'country': 'Bangladesh',
          'streak_count': 0,
        }).timeout(const Duration(seconds: 5));
        return; // Success — exit early.
      } catch (e) {
        // Silence retry logs
        if (attempt == maxAttempts) rethrow;
        // Exponential backoff before the next attempt.
        await Future.delayed(baseDelay * attempt);
      }
    }
  }

  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Sign in failed');
    }

    return await _fetchFullUser(response.user!.id);
  }

  @override
  Future<void> signInWithPhone({required String phone}) async {
    await _client.auth.signInWithOtp(phone: phone);
  }

  @override
  Future<UserModel> verifyPhoneOtp({
    required String phone,
    required String otp,
  }) async {
    final response = await _client.auth.verifyOTP(
      phone: phone,
      token: otp,
      type: supabase.OtpType.sms,
    );

    if (response.user == null) {
      throw Exception('OTP Verification failed');
    }

    return await _fetchFullUser(response.user!.id);
  }

  @override
  Future<void> updatePersonalization({
    required String educationLevel,
    required String languagePreference,
    required String country,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('No authenticated user');

    await _client.from('students').update({
      'education_level': educationLevel,
      'language_preference': languagePreference,
      'country': country,
    }).eq('id', user.id);
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    return await _fetchFullUser(user.id);
  }

  @override
  Stream<UserModel?> authStateChanges() {
    return _client.auth.onAuthStateChange.asyncMap((data) async {
      final user = data.session?.user;
      if (user == null) return null;
      return await _fetchFullUser(user.id);
    });
  }

  /// Helper to fetch combined data from profiles/students.
  Future<UserModel> _fetchFullUser(String userId) async {
    try {
      Map<String, dynamic>? profileData;
      
      // 1. Fetch Profile (with a short retry for newly signed-up users)
      try {
        profileData = await _client
            .from('profiles')
            .select()
            .eq('id', userId)
            .maybeSingle()
            .timeout(const Duration(seconds: 3));
            
        if (profileData == null) {
          // If profile is missing, it might be due to a slow DB trigger. Wait and retry once.
          await Future.delayed(const Duration(milliseconds: 1000));
          profileData = await _client
              .from('profiles')
              .select()
              .eq('id', userId)
              .maybeSingle()
              .timeout(const Duration(seconds: 3));
        }
      } catch (e) {
        // Trace error silently
      }

      // 2. Fetch Student data
      Map<String, dynamic>? studentData;
      try {
        studentData = await _client
            .from('students')
            .select('education_level, language_preference, country, streak_count')
            .eq('id', userId)
            .maybeSingle()
            .timeout(const Duration(seconds: 3));
      } catch (e) {
        // Trace error silently
      }

      final isFound = profileData != null || studentData != null;

      return UserModel.fromMap({
        ...?profileData,
        'role': studentData != null ? 'student' : (profileData != null ? 'agent' : 'student'),
        'is_student_active': isFound, 
        'education_level': studentData?['education_level'],
        'language_preference': studentData?['language_preference'],
        'country': studentData?['country'],
        'streak_count': studentData?['streak_count'],
      });
    } catch (e) {
      // Background fetch failed
      
      return UserModel(
        id: userId,
        role: UserRole.student,
        isStudentActive: false,
      );
    }
  }

  UserModel _mapToUserModel(supabase.User user, Map<String, dynamic> extra) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: extra['name'] as String?,
      phone: extra['phone'] as String?,
      role: UserRole.fromString(extra['role'] as String? ?? 'student'),
    );
  }
}
