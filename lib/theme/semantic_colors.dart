import 'package:flutter/material.dart';
import 'app_colors.dart';

/// ThemeExtension for semantic/extended colors not covered by Material 3 ColorScheme
@immutable
class SemanticColors extends ThemeExtension<SemanticColors> {
  const SemanticColors({
    required this.success,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.info,
    required this.infoContainer,
    required this.onInfoContainer,
    required this.pink,
    required this.pinkContainer,
    required this.onPinkContainer,
    required this.orange,
    required this.gradientStart,
    required this.gradientEnd,
  });

  final Color success;
  final Color successContainer;
  final Color onSuccessContainer;

  final Color warning;
  final Color warningContainer;
  final Color onWarningContainer;

  final Color info;
  final Color infoContainer;
  final Color onInfoContainer;

  final Color pink;
  final Color pinkContainer;
  final Color onPinkContainer;

  final Color orange;
  final Color gradientStart;
  final Color gradientEnd;

  static const light = SemanticColors(
    success: AppColors.success,
    successContainer: AppColors.successBackground,
    onSuccessContainer: Color(0xFF166534),
    warning: AppColors.warning,
    warningContainer: AppColors.warningBackground,
    onWarningContainer: Color(0xFF92400E),
    info: AppColors.info,
    infoContainer: AppColors.infoBackground,
    onInfoContainer: AppColors.primary800,
    pink: AppColors.pink,
    pinkContainer: AppColors.pinkBackground,
    onPinkContainer: AppColors.pinkDark,
    orange: AppColors.orange,
    gradientStart: AppColors.primary600,
    gradientEnd: AppColors.primary800,
  );

  static const dark = SemanticColors(
    success: AppColors.success,
    successContainer: AppColors.successBackgroundDark,
    onSuccessContainer: Color(0xFF4ADE80),
    warning: AppColors.warning,
    warningContainer: AppColors.warningBackgroundDark,
    onWarningContainer: Color(0xFFFCD34D),
    info: AppColors.info,
    infoContainer: AppColors.infoBackgroundDark,
    onInfoContainer: AppColors.primary200,
    pink: AppColors.pink,
    pinkContainer: AppColors.pinkBackgroundDark,
    onPinkContainer: Color(0xFFF9A8D4),
    orange: AppColors.orange,
    gradientStart: AppColors.primary800,
    gradientEnd: AppColors.primary900,
  );

  @override
  SemanticColors copyWith({
    Color? success, Color? successContainer, Color? onSuccessContainer,
    Color? warning, Color? warningContainer, Color? onWarningContainer,
    Color? info,    Color? infoContainer,    Color? onInfoContainer,
    Color? pink,    Color? pinkContainer,    Color? onPinkContainer,
    Color? orange,  Color? gradientStart,    Color? gradientEnd,
  }) =>
      SemanticColors(
        success: success ?? this.success,
        successContainer: successContainer ?? this.successContainer,
        onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
        warning: warning ?? this.warning,
        warningContainer: warningContainer ?? this.warningContainer,
        onWarningContainer: onWarningContainer ?? this.onWarningContainer,
        info: info ?? this.info,
        infoContainer: infoContainer ?? this.infoContainer,
        onInfoContainer: onInfoContainer ?? this.onInfoContainer,
        pink: pink ?? this.pink,
        pinkContainer: pinkContainer ?? this.pinkContainer,
        onPinkContainer: onPinkContainer ?? this.onPinkContainer,
        orange: orange ?? this.orange,
        gradientStart: gradientStart ?? this.gradientStart,
        gradientEnd: gradientEnd ?? this.gradientEnd,
      );

  @override
  SemanticColors lerp(SemanticColors? other, double t) {
    if (other is! SemanticColors) return this;
    return SemanticColors(
      success: Color.lerp(success, other.success, t)!,
      successContainer: Color.lerp(successContainer, other.successContainer, t)!,
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t)!,
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      onInfoContainer: Color.lerp(onInfoContainer, other.onInfoContainer, t)!,
      pink: Color.lerp(pink, other.pink, t)!,
      pinkContainer: Color.lerp(pinkContainer, other.pinkContainer, t)!,
      onPinkContainer: Color.lerp(onPinkContainer, other.onPinkContainer, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      gradientStart: Color.lerp(gradientStart, other.gradientStart, t)!,
      gradientEnd: Color.lerp(gradientEnd, other.gradientEnd, t)!,
    );
  }
}
