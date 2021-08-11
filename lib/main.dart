import 'package:flutter/material.dart';
import 'package:tv_shows/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TV Shows',
      theme: ThemeData(
        primaryColor: Color(0xFFFF758C),
        accentColor: Color(0xFFFF758C),
        fontFamily: 'Karla',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LoginPage(),
    );
  }
}
