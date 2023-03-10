import 'package:dio/dio.dart';
import 'package:pyc/data/clients/client_interface.dart';
import 'package:pyc/data/models/auth/requests/login_request.dart';
import 'package:pyc/data/providers/auth/auth_provider_interface.dart';

class AuthProvider implements IAuthProvider {
  final IClient<Dio> client;
  AuthProvider({required this.client});

  @override
  Future<Response> validateToken(String token) async {
    final client = this.client.getClient();
    return client.get(
      '/auth/token/validate',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }

  @override
  Future<Response> validateMyToken() async {
    final authClient = await client.getAuthClient();
    return authClient.get('/auth/token/validate');
  }

  @override
  Future<Response> login(String name, String password) {
    final req = LoginRequest(name, password);
    return client.getClient().post('/auth/login', data: req.toJson());
  }

  @override
  Future<void> logout() async {
    final authClient = await client.getAuthClient();
    await authClient.delete('/auth/logout');
  }
}
