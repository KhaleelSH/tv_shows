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
  }) async {
    try {
      _loggingIn = true;
      notifyListeners();
      final token = await client.api.login(email, password);
      client.api.setAuthorizationHeader(token);
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
    } catch (e) {
      rethrow;
    }
  }
}
