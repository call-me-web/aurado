import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/ui_extensions.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/onboarding_provider.dart';

class PersonalizationScreen extends ConsumerStatefulWidget {
  const PersonalizationScreen({super.key});

  @override
  ConsumerState<PersonalizationScreen> createState() => _PersonalizationScreenState();
}

class _PersonalizationScreenState extends ConsumerState<PersonalizationScreen> {
  String? _selectedLevel;
  String? _selectedLanguage;
  String? _selectedCountry = 'Bangladesh'; // Default

  final List<String> _levels = [
    'SSC',
    'HSC',
    'Admission',
    'Degree',
    'Skills/Job',
  ];

  final List<String> _languages = [
    'বাংলা',
    'English',
  ];

  final List<String> _countries = [
    'Bangladesh',
    'India',
    'Others',
  ];

  Future<void> _onComplete() async {
    if (_selectedLevel != null && _selectedLanguage != null && _selectedCountry != null) {
      // 1. Save to Remote (Supabase)
      await ref.read(authProvider.notifier).updatePersonalization(
            educationLevel: _selectedLevel!,
            languagePreference: _selectedLanguage!,
            country: _selectedCountry!,
          );
      
      // 2. Mark Locally as Completed
      await ref.read(personalizationProvider.notifier).completePersonalization();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => ref.read(personalizationProvider.notifier).completePersonalization(),
            child: Text(
              'পরে করব',
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
          ),
        ],
      ),
      body: authState.status == AuthStatus.loading 
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'তোমার সম্পর্কে জানি',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                12.heightBox,
                Text(
                  'সঠিক তথ্য দিলে আমরা তোমার জন্য সেরা কোর্সগুলো সাজিয়ে দিতে পারব।',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                40.heightBox,

                // --- Level Selection ---
                _buildSectionTitle('তুমি এখন কোন পর্যায়ে?'),
                16.heightBox,
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _levels.map((level) {
                    final isSelected = _selectedLevel == level;
                    return ChoiceChip(
                      label: Text(level),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedLevel = selected ? level : null);
                      },
                      selectedColor: colors.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? colors.onPrimary : colors.onSurface,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),
                32.heightBox,

                // --- Language Selection ---
                _buildSectionTitle('পছন্দের ভাষা?'),
                16.heightBox,
                Wrap(
                  spacing: 12,
                  children: _languages.map((lang) {
                    final isSelected = _selectedLanguage == lang;
                    return ChoiceChip(
                      label: Text(lang),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedLanguage = selected ? lang : null);
                      },
                      selectedColor: colors.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? colors.onPrimary : colors.onSurface,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),
                32.heightBox,

                // --- Country Selection ---
                _buildSectionTitle('দেশ?'),
                16.heightBox,
                Wrap(
                  spacing: 12,
                  children: _countries.map((country) {
                    final isSelected = _selectedCountry == country;
                    return ChoiceChip(
                      label: Text(country),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedCountry = selected ? country : null);
                      },
                      selectedColor: colors.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? colors.onPrimary : colors.onSurface,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),

                60.heightBox,

                // Start Button
                ElevatedButton(
                  onPressed: (_selectedLevel != null && _selectedLanguage != null && _selectedCountry != null)
                      ? _onComplete
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: colors.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'শুরু করি',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                if (authState.errorMessage != null) ...[
                  12.heightBox,
                  Text(
                    authState.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                48.heightBox,
              ],
            ),
          ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
