import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'semantic_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _buildTheme(
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary600,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primary50,
      onPrimaryContainer: AppColors.primary800,
      secondary: AppColors.teal,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFCCF2EF),
      onSecondaryContainer: Color(0xFF0D4D47),
      tertiary: AppColors.purple,
      onTertiary: Colors.white,
      tertiaryContainer: AppColors.purpleBackground,
      onTertiaryContainer: AppColors.purpleDark,
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: AppColors.errorBackground,
      onErrorContainer: Color(0xFF991B1B),
      surface: AppColors.neutral0,
      onSurface: AppColors.neutral900,
      onSurfaceVariant: AppColors.neutral400,
      outline: AppColors.neutral200,
      outlineVariant: AppColors.neutral200,
    ),
    scaffoldBackgroundColor: AppColors.neutral50,
    inputFillColor: AppColors.neutral0,
    switchInactiveTrackColor: AppColors.neutral200,
    switchInactiveThumbColor: AppColors.neutral0,
    navBackgroundColor: AppColors.neutral0,
    navActiveColor: AppColors.primary600,
    navInactiveColor: AppColors.neutral400,
    semanticColors: SemanticColors.light,
  );

  static ThemeData get dark => _buildTheme(
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary400,
      onPrimary: AppColors.primary900,
      primaryContainer: AppColors.primary800,
      onPrimaryContainer: AppColors.primary200,
      secondary: AppColors.teal,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFF0D3D3A),
      onSecondaryContainer: Color(0xFF99EAE5),
      tertiary: AppColors.purple,
      onTertiary: Colors.white,
      tertiaryContainer: AppColors.purpleBackgroundDark,
      onTertiaryContainer: Color(0xFFC4B5FD),
      error: Color(0xFFF87171),
      onError: Color(0xFF2D1111),
      errorContainer: AppColors.errorBackgroundDark,
      onErrorContainer: Color(0xFFFCA5A5),
      surface: AppColors.darkCard,
      onSurface: Color(0xFFE5E5E5),
      onSurfaceVariant: Color(0xFF737373),
      outline: AppColors.darkBorder,
      outlineVariant: AppColors.darkBorder,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    inputFillColor: AppColors.darkCard,
    switchInactiveTrackColor: AppColors.darkBorder,
    switchInactiveThumbColor: AppColors.neutral400,
    navBackgroundColor: AppColors.darkBackground,
    navActiveColor: AppColors.primary400,
    navInactiveColor: AppColors.neutral600,
    semanticColors: SemanticColors.dark,
  );

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Color scaffoldBackgroundColor,
    required Color inputFillColor,
    required Color switchInactiveTrackColor,
    required Color switchInactiveThumbColor,
    required Color navBackgroundColor,
    required Color navActiveColor,
    required Color navInactiveColor,
    required SemanticColors semanticColors,
  }) =>
      ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: _textTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: inputFillColor,
          hintStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: colorScheme.outline, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: colorScheme.outline, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return colorScheme.primary;
            return switchInactiveThumbColor;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.primary.withValues(alpha: 0.3);
            }
            return switchInactiveTrackColor;
          }),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: navBackgroundColor,
          selectedItemColor: navActiveColor,
          unselectedItemColor: navInactiveColor,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: const TextStyle(fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
        ),
        dividerTheme: DividerThemeData(
          color: colorScheme.outline,
          thickness: 0.5,
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          showDragHandle: true,
          dragHandleColor: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
        ),
        extensions: [semanticColors],
      );

  static const TextTheme _textTheme = TextTheme(
    headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, letterSpacing: -0.5),
    titleSmall:     TextStyle(fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: -0.3),
    bodyLarge:      TextStyle(fontSize: 14),
    bodyMedium:     TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    bodySmall:      TextStyle(fontSize: 13),
    labelLarge:     TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
    labelMedium:    TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    labelSmall:     TextStyle(fontSize: 11),
  );
}
