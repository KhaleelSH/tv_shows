import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDataClient {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  static const String _token = 'TOKEN';

  Future<void> setToken(String token) async {
    await storage.write(key: _token, value: token);
  }

  Future<void> removeToken() async {
    await storage.delete(key: _token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: _token);
  }
}
