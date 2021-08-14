import 'package:flutter/material.dart';
import 'package:tv_shows/data/data_client.dart';

class AuthProvider extends ChangeNotifier {
  final DataClient client;

  AuthProvider(this.client);

  bool _loggingIn = false;

  bool get loggingIn => _loggingIn;

  Future<void> login({
    required String email,
    required String password,
    required bool rememberToken,
  }) async {
    try {
      _loggingIn = true;
      notifyListeners();
      final token = await client.api.login(email, password);
      client.api.setAuthorizationHeader(token);
      if (rememberToken) {
        client.local.setToken(token);
      }
    } catch (e) {
      rethrow;
    } finally {
      _loggingIn = false;
      notifyListeners();
    }
  }

  void logout() async {
    try {
      client.api.clearAuthorizationHeader();
      client.local.removeToken();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> useRememberedToken() async {
    final String? token = await client.local.getToken();
    if (token != null) {
      client.api.setAuthorizationHeader(token);
      return true;
    }
    return false;
  }
}
