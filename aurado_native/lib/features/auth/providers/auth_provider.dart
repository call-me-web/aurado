import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aurado/core/di/service_locator.dart';
import 'package:aurado/features/auth/domain/models/user_model.dart';
import 'package:aurado/features/auth/domain/repositories/auth_repository.dart';
import 'package:aurado/features/sync/domain/repositories/backup_repository.dart';

/// Represents the possible states of authentication.
enum AuthStatus {
  /// App is checking for an active session.
  initial,
  /// User is not logged in.
  unauthenticated,
  /// Auth operation (login/signup) is in progress.
  loading,
  /// User successfully authenticated.
  authenticated,
  /// Operation failed.
  error,
}

/// State object for the AuthProvider.
class AuthStateData {
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;
  final bool canRestore;

  AuthStateData({
    required this.status,
    this.user,
    this.errorMessage,
    this.canRestore = false,
  });

  factory AuthStateData.initial() => AuthStateData(status: AuthStatus.initial);
  factory AuthStateData.loading() => AuthStateData(status: AuthStatus.loading);
  factory AuthStateData.unauthenticated() => AuthStateData(status: AuthStatus.unauthenticated);
  factory AuthStateData.authenticated(UserModel user, {bool canRestore = false}) => 
      AuthStateData(status: AuthStatus.authenticated, user: user, canRestore: canRestore);
  factory AuthStateData.error(String message) => 
      AuthStateData(status: AuthStatus.error, errorMessage: message);
}

/// Manages global authentication logic and state.
class AuthNotifier extends Notifier<AuthStateData> {
  AuthRepository get _repository => sl.get<AuthRepository>();
  BackupRepository get _backupRepository => sl.get<BackupRepository>();
  StreamSubscription<UserModel?>? _subscription;

  @override
  AuthStateData build() {
    debugPrint('DEBUG: AuthNotifier build() START');
    
    // Listen to real-time auth changes from Supabase
    _subscription?.cancel();
    _subscription = _repository.authStateChanges().listen((user) {
      debugPrint('DEBUG: AuthStateChange - User: ${user?.id}');
      if (user != null) {
        _handlePostAuth(user);
      } else {
        state = AuthStateData.unauthenticated();
      }
    }, onError: (e) {
      debugPrint('DEBUG: ERROR in AuthStateChange stream: $e');
    });

    // Check pre-existing session
    _checkInitialAuth();

    debugPrint('DEBUG: AuthNotifier build() returning INITIAL');
    return AuthStateData.initial();
  }

  Future<void> _checkInitialAuth() async {
    debugPrint('DEBUG: Checking initial auth...');
    try {
      final user = await _repository.getCurrentUser();
      debugPrint('DEBUG: Initial auth check complete - User: ${user?.id}');
      if (user != null) {
        _handlePostAuth(user);
      } else {
        state = AuthStateData.unauthenticated();
      }
    } catch (e, stack) {
      debugPrint('DEBUG: ERROR in _checkInitialAuth: $e');
      debugPrint('DEBUG: StackTrace: $stack');
      state = AuthStateData.unauthenticated();
    }
  }

  Future<void> signIn(String email, String password) async {
    state = AuthStateData.loading();
    try {
      final user = await _repository.signInWithEmail(email: email, password: password);
      state = AuthStateData.authenticated(user);
    } catch (e) {
      state = AuthStateData.error(e.toString());
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    state = AuthStateData.loading();
    try {
      final user = await _repository.signUpWithEmail(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
      state = AuthStateData.authenticated(user);
    } catch (e) {
      state = AuthStateData.error(e.toString());
    }
  }

  Future<void> updatePersonalization({
    required String educationLevel,
    required String languagePreference,
    required String country,
  }) async {
    try {
      await _repository.updatePersonalization(
        educationLevel: educationLevel,
        languagePreference: languagePreference,
        country: country,
      );
      
      // Refresh user data locally
      if (state.user != null) {
        state = AuthStateData.authenticated(
          state.user!.copyWith(
            // Note: copyWith needs to be updated in UserModel as well
          ),
        );
        // Actually, re-fetching is safer and cleaner since fromMap handles it
        await _checkInitialAuth();
      }
    } catch (e) {
      state = AuthStateData.error(e.toString());
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
    state = AuthStateData.unauthenticated();
  }

  Future<void> _handlePostAuth(UserModel user) async {
    state = AuthStateData.authenticated(user);
    
    // Check for backup if local data is empty
    try {
      final hasBackup = await _backupRepository.hasBackup(user.id);
      if (hasBackup) {
        // Here we could add logic to check if local DB is empty
        // For simplicity, we just set the flag to prompt the UI
        state = AuthStateData.authenticated(user, canRestore: true);
      }
    } catch (e) {
      debugPrint('DEBUG: Error checking backup: $e');
    }
  }

  Future<void> restoreProgress() async {
    final user = state.user;
    if (user == null) return;

    state = AuthStateData.loading();
    try {
      await _backupRepository.restoreBackup(user.id);
      state = AuthStateData.authenticated(user, canRestore: false);
    } catch (e) {
      state = AuthStateData.error('Restore failed: $e');
    }
  }
}

/// Global provider for checking Auth state and performing login/logout.
final authProvider = NotifierProvider<AuthNotifier, AuthStateData>(() {
  return AuthNotifier();
});
