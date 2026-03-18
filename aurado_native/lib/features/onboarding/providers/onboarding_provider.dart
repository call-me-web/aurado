import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize in main.dart');
});

class OnboardingNotifier extends Notifier<bool> {
  static const _key = 'onboarding_completed';

  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(_key) ?? false;
  }

  Future<void> completeOnboarding() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_key, true);
    state = true;
  }
}

final onboardingProvider = NotifierProvider<OnboardingNotifier, bool>(OnboardingNotifier.new);

class PersonalizationNotifier extends Notifier<bool> {
  static const _key = 'personalization_completed';

  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(_key) ?? false;
  }

  Future<void> completePersonalization() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_key, true);
    state = true;
  }
}

final personalizationProvider = NotifierProvider<PersonalizationNotifier, bool>(PersonalizationNotifier.new);
