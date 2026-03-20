import 'package:flutter/material.dart';

/// Design system color tokens
class AppColors {
  AppColors._();

  // Primary (Blue)
  static const primary50  = Color(0xFFEBF3FF);
  static const primary100 = Color(0xFFC2DAFF);
  static const primary200 = Color(0xFF85B4FF);
  static const primary400 = Color(0xFF4A8AFF);
  static const primary600 = Color(0xFF1A5CBA);
  static const primary800 = Color(0xFF0D3D82);
  static const primary900 = Color(0xFF062452);

  // Neutral
  static const neutral0   = Color(0xFFFFFFFF);
  static const neutral50  = Color(0xFFF5F5F5);
  static const neutral200 = Color(0xFFE5E5E5);
  static const neutral400 = Color(0xFFA3A3A3);
  static const neutral600 = Color(0xFF525252);
  static const neutral800 = Color(0xFF262626);
  static const neutral900 = Color(0xFF0A0A0A);

  // Dark mode surfaces
  static const darkBackground = Color(0xFF0F0F0F);
  static const darkSurface    = Color(0xFF1A1A1A);
  static const darkCard       = Color(0xFF262626);
  static const darkBorder     = Color(0xFF3D3D3D);

  // Semantic
  static const success               = Color(0xFF22C55E);
  static const successBackground     = Color(0xFFE8F9EE);
  static const successBackgroundDark = Color(0xFF0D2818);

  static const error               = Color(0xFFEF4444);
  static const errorBackground     = Color(0xFFFDE8E8);
  static const errorBackgroundDark = Color(0xFF2D1111);

  static const warning               = Color(0xFFF59E0B);
  static const warningBackground     = Color(0xFFFFF8E1);
  static const warningBackgroundDark = Color(0xFF2D2006);

  static const info               = Color(0xFF3B82F6);
  static const infoBackground     = Color(0xFFEBF3FF);
  static const infoBackgroundDark = Color(0xFF0D1F3D);

  // Extended
  static const teal   = Color(0xFF14B8A6);

  static const purple               = Color(0xFF8B5CF6);
  static const purpleDark           = Color(0xFF6D28D9);
  static const purpleBackground     = Color(0xFFF0ECFE);
  static const purpleBackgroundDark = Color(0xFF1A0D33);

  static const pink               = Color(0xFFEC4899);
  static const pinkDark           = Color(0xFFBE185D);
  static const pinkBackground     = Color(0xFFFDE8F0);
  static const pinkBackgroundDark = Color(0xFF2D0D1A);

  static const orange = Color(0xFFF97316);

  // ── Warm palette (Amber-tinted — no pure neutrals) ──────────────────
  // Brand
  static const warmPrimary50  = Color(0xFFFFFBEB);
  static const warmPrimary200 = Color(0xFFFDE68A);
  static const warmPrimary400 = Color(0xFFFBBF24);
  static const warmPrimary600 = Color(0xFFD97706); // Amber-600
  static const warmPrimary800 = Color(0xFF92400E); // Amber-800
  static const warmPrimary900 = Color(0xFF78350F); // Amber-900

  // Warm-tinted surfaces (never pure white/gray)
  static const warmNeutral0   = Color(0xFFFFFDF7); // warm white
  static const warmNeutral50  = Color(0xFFFAF5EE); // scaffold bg
  static const warmNeutral200 = Color(0xFFE8D9C4); // border
  static const warmNeutral400 = Color(0xFFA07850); // secondary text
  static const warmNeutral600 = Color(0xFF5C4030);
  static const warmNeutral900 = Color(0xFF1C0F07); // near-black

  // Warm dark surfaces
  static const warmDarkBackground = Color(0xFF150D05);
  static const warmDarkCard       = Color(0xFF2A1A0C);
  static const warmDarkBorder     = Color(0xFF443020);

  // ── Cool palette (Cyan-tinted — no pure neutrals) ────────────────────
  // Brand
  static const coolPrimary50  = Color(0xFFECFEFF);
  static const coolPrimary200 = Color(0xFFA5F3FC);
  static const coolPrimary400 = Color(0xFF22D3EE);
  static const coolPrimary600 = Color(0xFF0891B2); // Cyan-600
  static const coolPrimary800 = Color(0xFF155E75); // Cyan-800
  static const coolPrimary900 = Color(0xFF083344); // Cyan-900

  // Cool-tinted surfaces (never pure white/gray)
  static const coolNeutral0   = Color(0xFFF8FBFF); // cool white
  static const coolNeutral50  = Color(0xFFEEF4FF); // scaffold bg
  static const coolNeutral200 = Color(0xFFC4D4E8); // border
  static const coolNeutral400 = Color(0xFF6A8FB0); // secondary text
  static const coolNeutral600 = Color(0xFF2A4A6E);
  static const coolNeutral900 = Color(0xFF060F1E); // near-black

  // Cool dark surfaces
  static const coolDarkBackground = Color(0xFF050C1A);
  static const coolDarkCard       = Color(0xFF0F1E35);
  static const coolDarkBorder     = Color(0xFF1A3050);
}
