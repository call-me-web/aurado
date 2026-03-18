import 'package:flutter/material.dart';

/// Extension on [num] to provide easy spacing utilities.
/// 
/// Instead of writing:
/// `SizedBox(height: ThemeConfig.spacingMd)`
/// 
/// You can simply write:
/// `16.heightBox` or `ThemeConfig.spacingMd.heightBox`
extension SpacingExtension on num {
  /// Returns a [SizedBox] with the specified height.
  SizedBox get heightBox => SizedBox(height: toDouble());

  /// Returns a [SizedBox] with the specified width.
  SizedBox get widthBox => SizedBox(width: toDouble());
}
