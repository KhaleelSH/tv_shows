import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:tv_shows/pages/login_page.dart';
import 'package:tv_shows/utils/app_theme.dart';

void main() {
  Loggy.initLoggy(logPrinter: const PrettyPrinter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TV Shows',
      theme: AppTheme.from(theme: AppThemeLight()),
      home: const LoginPage(),
    );
  }
}
