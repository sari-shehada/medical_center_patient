import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData get lightTheme => ThemeData(
      fontFamily: 'Jannat',
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onPrimary,
        error: error,
        onError: onError,
        background: backgroundColor,
        onBackground: onBackground,
        surface: surface,
        onSurface: onSurface,
      ),
    );
