import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/tokens/app_colors.dart';
import 'package:zhu_app/design_system/tokens/app_spacing.dart';

abstract final class AppShadTheme {
  static ShadColorScheme get colors => const ShadColorScheme(
    background: AppColors.background,
    foreground: AppColors.foreground,
    card: AppColors.surface,
    cardForeground: AppColors.foreground,
    popover: AppColors.surface,
    popoverForeground: AppColors.foreground,
    primary: AppColors.primary,
    primaryForeground: Colors.white,
    secondary: AppColors.surfaceContainer,
    secondaryForeground: AppColors.foreground,
    muted: AppColors.surfaceContainer,
    mutedForeground: AppColors.mutedForeground,
    accent: AppColors.primaryContainer,
    accentForeground: AppColors.onPrimaryContainer,
    destructive: AppColors.error,
    destructiveForeground: Colors.white,
    border: AppColors.outline,
    input: AppColors.outlineStrong,
    ring: AppColors.draftingBlue,
    selection: AppColors.primaryContainer,
    custom: {
      'draftingBlue': AppColors.draftingBlue,
      'primaryContainer': AppColors.primaryContainer,
      'onPrimaryContainer': AppColors.onPrimaryContainer,
      'pencilGrey': AppColors.pencilGrey,
      'surfaceContainerHigh': AppColors.surfaceContainerHigh,
      'divider': AppColors.divider,
      'success': AppColors.success,
      'warning': AppColors.warning,
    },
  );

  static ShadTextTheme get textTheme => ShadTextTheme(
    family: 'IBMPlexSans',
    h1Large: const TextStyle(
      fontFamily: 'IBMPlexSans',
      fontSize: 40,
      fontWeight: FontWeight.w700,
      height: 1.1,
      letterSpacing: -0.8,
    ),
    h1: const TextStyle(
      fontFamily: 'IBMPlexSans',
      fontSize: 32,
      fontWeight: FontWeight.w700,
      height: 1.15,
      letterSpacing: -0.4,
    ),
    h2: const TextStyle(
      fontFamily: 'IBMPlexSans',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.25,
    ),
    h3: const TextStyle(
      fontFamily: 'IBMPlexSans',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.35,
    ),
    h4: const TextStyle(
      fontFamily: 'IBMPlexSans',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    p: const TextStyle(
      fontFamily: 'IBMPlexSans',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    blockquote: const TextStyle(
      fontFamily: 'IBMPlexSans',
      fontSize: 16,
      height: 1.5,
    ),
    table: const TextStyle(
      fontFamily: 'IBMPlexSans',
      fontSize: 14,
      height: 1.5,
    ),
    list: const TextStyle(fontFamily: 'IBMPlexSans', fontSize: 14, height: 1.5),
    lead: const TextStyle(fontFamily: 'IBMPlexSans', fontSize: 16, height: 1.5),
    large: const TextStyle(
      fontFamily: 'IBMPlexSans',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    small: const TextStyle(
      fontFamily: 'IBMPlexSans',
      fontSize: 14,
      height: 1.5,
    ),
    muted: const TextStyle(
      fontFamily: 'IBMPlexSans',
      fontSize: 14,
      height: 1.5,
      color: AppColors.mutedForeground,
    ),
    custom: {
      'label': const TextStyle(
        fontFamily: 'IBMPlexSans',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.3,
        letterSpacing: 0.3,
      ),
      'technical': const TextStyle(
        fontFamily: 'IBMPlexMono',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.2,
      ),
    },
  );

  static ShadThemeData get light => ShadThemeData(
    brightness: Brightness.light,
    colorScheme: colors,
    textTheme: textTheme,
    radius: const BorderRadius.all(AppRadius.medium),
    primaryButtonTheme: const ShadButtonTheme(
      height: 48,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      pressedBackgroundColor: AppColors.draftingBlue,
    ),
    secondaryButtonTheme: const ShadButtonTheme(height: 48),
    outlineButtonTheme: const ShadButtonTheme(height: 48),
    ghostButtonTheme: const ShadButtonTheme(height: 48),
    destructiveButtonTheme: const ShadButtonTheme(height: 48),
    linkButtonTheme: const ShadButtonTheme(height: 48),
    progressTheme: const ShadProgressTheme(
      minHeight: 8,
      color: AppColors.draftingBlue,
      backgroundColor: AppColors.surfaceContainer,
      borderRadius: BorderRadius.all(AppRadius.small),
      innerBorderRadius: BorderRadius.all(AppRadius.small),
    ),
  );
}

extension AppTextTheme on ShadTextTheme {
  TextStyle get label => custom['label'] ?? small;
  TextStyle get technical => custom['technical'] ?? small;
}
