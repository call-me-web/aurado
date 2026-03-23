import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aurado/core/theme/theme_provider.dart';

void main() {
  group('ThemeNotifier Tests', () {
    test('updateTheme with identical values does not notify listeners', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      int notifyCount = 0;
      container.listen<ThemeState>(
        themeProvider,
        (prev, next) {
          notifyCount++;
        },
        fireImmediately: false,
      );

      final notifier = container.read(themeProvider.notifier);
      final initialState = container.read(themeProvider);

      // Call updateTheme with identical values
      notifier.updateTheme(
        primaryColor: initialState.primaryColor,
        secondaryColor: initialState.secondaryColor,
        // ... (other fields)
      );

      expect(notifyCount, 0, reason: 'Identifier update should NOT trigger a rebuild');

      // Call updateTheme with a new value
      notifier.updateTheme(primaryColor: Colors.red);
      expect(notifyCount, 1, reason: 'New value SHOULD trigger a rebuild');
    });

    test('updateTheme with new backgroundColor and cardColor updates state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(themeProvider.notifier);
      
      const newBgColor = Color(0xFF123456);
      const newCardColor = Color(0xFF654321);

      notifier.updateTheme(
        backgroundColor: newBgColor,
        cardColor: newCardColor,
      );

      final state = container.read(themeProvider);
      expect(state.backgroundColor, newBgColor);
      expect(state.cardColor, newCardColor);
    });
  });
}
