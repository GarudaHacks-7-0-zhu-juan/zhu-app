import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

abstract final class AppColors {
  static const background = Color(0xFFF9F9F9);
  static const foreground = Color(0xFF222222);
  static const surface = Color(0xFFFCFCFC);
  static const surfaceContainer = Color(0xFFF1F2F3);
  static const surfaceContainerHigh = Color(0xFFE8EAEC);
  static const primary = Color(0xFF5B9BD5);
  static const draftingBlue = Color(0xFF4A90E2);
  static const primaryContainer = Color(0xFFDCEBFA);
  static const onPrimaryContainer = Color(0xFF17344F);
  static const pencilGrey = Color(0xFF808080);
  static const mutedForeground = Color(0xFF676C72);
  static const outline = Color(0xFFC7CBD0);
  static const outlineStrong = Color(0xFF9CA2A8);
  static const divider = Color(0xFFD9DDE1);
  static const error = Color(0xFFB3261E);
  static const errorContainer = Color(0xFFF9DEDC);
  static const success = Color(0xFF2E7D5B);
  static const warning = Color(0xFFA15C00);
}

extension AppShadColors on ShadColorScheme {
  Color get draftingBlue => custom['draftingBlue'] ?? primary;
  Color get primaryContainer => custom['primaryContainer'] ?? accent;
  Color get onPrimaryContainer => custom['onPrimaryContainer'] ?? foreground;
  Color get pencilGrey => custom['pencilGrey'] ?? mutedForeground;
  Color get surfaceContainerHigh => custom['surfaceContainerHigh'] ?? muted;
  Color get outlineStrong => custom['outlineStrong'] ?? input;
  Color get divider => custom['divider'] ?? border;
  Color get success => custom['success'] ?? primary;
  Color get warning => custom['warning'] ?? primary;
}
