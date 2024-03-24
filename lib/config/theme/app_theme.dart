import 'package:flutter/material.dart';
import 'package:medical_center_patient/config/theme/app_colors.dart';

ThemeData get lightTheme => ThemeData(
      fontFamily: 'Jannat',
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        // brightness: Brightness.light,
        // primary: primary,
        // onPrimary: onPrimary,
        // secondary: secondary,
        // onSecondary: onPrimary,
        // error: error,
        // onError: onError,
        // background: background,
        // onBackground: onBackground,
        // surface: surface,
        // onSurface: onSurface,
      ),
    );
