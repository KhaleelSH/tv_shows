import 'package:flutter/material.dart';
import 'package:tv_shows/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TV Shows',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF758C),
        accentColor: const Color(0xFFFF758C),
        fontFamily: 'Karla',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginPage(),
    );
  }
}
