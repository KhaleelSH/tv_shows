import 'package:flutter/material.dart';
import 'package:tv_shows/utils/app_colors.dart';

abstract class AppTheme {
  MaterialColor get primarySwatch;

  String get fontFamily;

  Color get scaffoldBackgroundColor;

  Brightness get brightness;

  InputDecorationTheme get inputDecorationTheme;

  TextTheme get textTheme;

  AppBarTheme get appBarTheme;

  static ThemeData from({required AppTheme theme}) {
    return ThemeData(
      primarySwatch: theme.primarySwatch,
      fontFamily: theme.fontFamily,
      scaffoldBackgroundColor: theme.scaffoldBackgroundColor,
      brightness: theme.brightness,
      inputDecorationTheme: theme.inputDecorationTheme,
      textTheme: theme.textTheme,
      splashColor: theme.primarySwatch.shade100,
      highlightColor: theme.primarySwatch.shade100,
      appBarTheme: theme.appBarTheme,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: theme.primarySwatch),
    );
  }
}

class AppThemeLight extends AppTheme {
  Map<int, Color> get _color => {
        50: Color(AppColors.primaryColor()).withOpacity(0.1),
        100: Color(AppColors.primaryColor()).withOpacity(0.2),
        200: Color(AppColors.primaryColor()).withOpacity(0.3),
        300: Color(AppColors.primaryColor()).withOpacity(0.4),
        400: Color(AppColors.primaryColor()).withOpacity(0.5),
        500: Color(AppColors.primaryColor()).withOpacity(0.6),
        600: Color(AppColors.primaryColor()).withOpacity(0.7),
        700: Color(AppColors.primaryColor()).withOpacity(0.8),
        800: Color(AppColors.primaryColor()).withOpacity(0.9),
        900: Color(AppColors.primaryColor()).withOpacity(1.0),
      };

  @override
  MaterialColor get primarySwatch =>
      MaterialColor(AppColors.primaryColor(), _color);

  @override
  String get fontFamily => 'Karla';

  @override
  Color get scaffoldBackgroundColor => Colors.white;

  @override
  Brightness get brightness => Brightness.light;

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Color(AppColors.lightGrey())),
      );

  @override
  TextTheme get textTheme => TextTheme(
        headline1: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(AppColors.primaryBlack()),
        ),
        headline2: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(AppColors.primaryBlack()),
        ),
        headline3: TextStyle(
          fontSize: 20,
          color: Color(AppColors.darkGrey()),
        ),
        button: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          color: Color(AppColors.darkGrey()),
        ),
        caption: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(AppColors.darkGrey()),
        ),
      );

  @override
  AppBarTheme get appBarTheme => const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
      );
}
