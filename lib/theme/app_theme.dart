import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized color palette for the Adstacks dashboard.
class AppColors {
  AppColors._();

  // Base surfaces
  static const Color scaffoldBg = Color(0xFFF5F6FA);
  static const Color sidebarBg = Color(0xFFFFFFFF);
  static const Color cardBg = Color(0xFFFFFFFF);

  // Dark navy panel (used for "Top Creators" card and right rail)
  static const Color navyPanel = Color(0xFF1F1D2B);
  static const Color navyPanelLight = Color(0xFF2B2A40);

  // Brand / accent
  static const Color primaryPurple = Color(0xFF6C5DD3);
  static const Color primaryPurpleDark = Color(0xFF4A3FB5);
  static const Color pink = Color(0xFFFF6B9D);
  static const Color blueAccent = Color(0xFF4F86F7);

  // Text
  static const Color textPrimary = Color(0xFF1F1D2B);
  static const Color textDark = textPrimary;
  static const Color textSecondary = Color(0xFF8B8D97);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnDarkMuted = Color(0xFFB6B4C5);

  // Status / utility
  static const Color divider = Color(0xFFEDEDF5);
  static const Color success = Color(0xFF4CD787);
  static const Color warning = Color(0xFFFFAB2D);
  static const Color danger = Color(0xFFFF6B6B);

  // Chart lines
  static const Color chartPending = Color(0xFFFF8FB1);
  static const Color chartDone = Color(0xFF6C5DD3);
}

/// Gradients reused across cards (e.g. the "Top Rating Project" banner).
class AppGradients {
  AppGradients._();

  static const LinearGradient bannerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF6B9D),
      Color(0xFF8E6BE0),
      Color(0xFF4F86F7),
    ],
  );

  static const LinearGradient purpleButton = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF7C6CE0),
      Color(0xFF6C5DD3),
    ],
  );

  static const LinearGradient navyPanelGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF24222F),
      Color(0xFF1F1D2B),
    ],
  );
}

/// Reusable text styles built on Google Fonts (Inter / Poppins family).
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get _base => GoogleFonts.inter(color: AppColors.textPrimary);

  static TextStyle get h1 => _base.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      );

  static TextStyle get h2 => _base.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get h3 => _base.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get body => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get bodyDark => body;

  static TextStyle get bodyMuted => _base.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get caption => _base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  static TextStyle get navLabel => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  static TextStyle get navLabelActive => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textOnDark,
      );

  static TextStyle get onDarkBody => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textOnDark,
      );

  static TextStyle get onDarkMuted => _base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textOnDarkMuted,
      );
}

/// App-wide [ThemeData] for the dashboard.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.scaffoldBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryPurple,
        brightness: Brightness.light,
        primary: AppColors.primaryPurple,
        surface: AppColors.cardBg,
      ),
      fontFamily: GoogleFonts.inter().fontFamily,
    );

    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      dividerColor: AppColors.divider,
      cardTheme: const CardThemeData(
        color: AppColors.cardBg,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}

/// Shared radius/spacing constants so every widget stays consistent.
class AppDims {
  AppDims._();

  static const double cardRadius = 20;
  static const double smallRadius = 14;
  static const double pillRadius = 100;

  static const double gapXs = 4;
  static const double gapSm = 8;
  static const double gapMd = 16;
  static const double gapLg = 24;
  static const double gapXl = 32;
}
