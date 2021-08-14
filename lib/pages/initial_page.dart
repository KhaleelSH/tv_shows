import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/pages/login_page.dart';
import 'package:tv_shows/pages/shows_page.dart';
import 'package:tv_shows/state/auth_provider.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (await Provider.of<AuthProvider>(context, listen: false)
          .useRememberedToken()) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ShowsPage()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 16),
            const CircularProgressIndicator.adaptive(),
          ],
        ),
      ),
    );
  }
}
