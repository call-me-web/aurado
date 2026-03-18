import 'package:flutter/material.dart';

/// Global BuildContext extensions.
extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  bool get isSmallScreen => screenWidth < 400;
}

/// String extensions.
extension StringExtensions on String {
  /// Returns null if the string is empty.
  String? get nullIfEmpty => isEmpty ? null : this;

  /// Capitalizes the first letter.
  String get capitalized =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

/// DateTime extensions.
extension DateTimeExtensions on DateTime {
  /// Whether this DateTime is before [DateTime.now()].
  bool get isExpired => isBefore(DateTime.now());

  /// Friendly display: "Mar 13, 2026"
  String get displayDate {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[month - 1]} $day, $year';
  }
}
