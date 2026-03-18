import '../models/user_model.dart';

/// Contract for the authentication service layer.
/// 
/// Decouples the domain logic from specific providers like Supabase.
abstract class AuthRepository {
  /// Signs up a new user via Email and Password.
  /// 
  /// Triggers account creation in [public.profiles] and [public.students].
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String phone,
  });

  /// Signs in an existing user via Email.
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });

  /// Initiates Phone OTP sequence.
  Future<void> signInWithPhone({required String phone});

  /// Verifies a Phone OTP and completes sign-in.
  Future<UserModel> verifyPhoneOtp({
    required String phone,
    required String otp,
  });

  /// Signs out the current user.
  Future<void> signOut();

  /// Retrieves the currently authenticated user session.
  /// 
  /// Returns null if no session exists.
  Future<UserModel?> getCurrentUser();

  /// Stream of authentication state changes.
  Stream<UserModel?> authStateChanges();

  /// Updates student personalization data.
  Future<void> updatePersonalization({
    required String educationLevel,
    required String languagePreference,
    required String country,
  });
}
