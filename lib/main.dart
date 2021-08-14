import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/data/api_data_client.dart';
import 'package:tv_shows/pages/login_page.dart';
import 'package:tv_shows/state/auth_provider.dart';
import 'package:tv_shows/state/shows_provider.dart';
import 'package:tv_shows/utils/app_theme.dart';

void main() {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(showColors: true),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiDataClient>(
          create: (_) => ApiDataClient(),
        ),
        ChangeNotifierProxyProvider<ApiDataClient, AuthProvider>(
          create: (context) => AuthProvider(context.read<ApiDataClient>()),
          update: (_, ApiDataClient client, AuthProvider? auth) => auth!,
        ),
        ChangeNotifierProxyProvider<ApiDataClient, ShowsProvider>(
          create: (context) => ShowsProvider(context.read<ApiDataClient>()),
          update: (_, ApiDataClient client, ShowsProvider? auth) => auth!,
        ),
      ],
      child: MaterialApp(
        title: 'TV Shows',
        theme: AppTheme.from(theme: AppThemeLight()),
        home: const LoginPage(),
      ),
    );
  }
}
