import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/state/auth_provider.dart';
import 'package:tv_shows/utils/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  bool _rememberMe = false;
  bool _isObscurePassword = true;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 48),
            TextFormField(
              controller: _emailController,
              focusNode: _emailNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              style: const TextStyle(fontWeight: FontWeight.bold),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                final _emailRegExp = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                final _isValid = _emailRegExp.hasMatch(value!);
                if (_isValid) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    setState(() {
                      _isEmailValid = true;
                    });
                  });
                } else {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    setState(() {
                      _isEmailValid = false;
                    });
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              focusNode: _passwordNode,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() => _isObscurePassword = !_isObscurePassword);
                  },
                  icon: Icon(_isObscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  tooltip:
                      _isObscurePassword ? 'Show Password' : 'Hide Password',
                ),
              ),
              obscureText: _isObscurePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.length >= 8) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    setState(() {
                      _isPasswordValid = true;
                    });
                  });
                } else {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    setState(() {
                      _isPasswordValid = false;
                    });
                  });
                }
              },
            ),
            const SizedBox(height: 16),
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
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    setState(() => _rememberMe = !_rememberMe);
                  },
                  child: const Text('Remember me'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Consumer<AuthProvider>(
              builder: (context, provider, child) {
                if (provider.loggingIn) {
                  return const CircularProgressIndicator.adaptive();
                }
                return TextButton(
                  onPressed: _isLoginAllowed()
                      ? () async {
                          // To hide keyboard when sending the login request.
                          _emailNode.unfocus();
                          _passwordNode.unfocus();
                          try {
                            await provider.login(
                              email: _emailController.text,
                              password: _passwordController.text,
                              rememberToken: _rememberMe,
                            );
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.shows);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text('LOG IN'),
                    ],
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .primaryColor
                        .withAlpha(_isLoginAllowed() ? 255 : 100),
                    primary: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _isLoginAllowed() {
    return _isEmailValid && _isPasswordValid;
  }
}
