import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  bool _isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 48),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() => _isObscurePassword = !_isObscurePassword);
                  },
                  icon: Icon(Icons.remove_red_eye_outlined),
                ),
              ),
              obscureText: _isObscurePassword,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() => _rememberMe = value!);
                    },
                    fillColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    setState(() => _rememberMe = !_rememberMe);
                  },
                  child: Text('Remember me'),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LOG IN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                primary: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
