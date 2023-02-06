import 'package:dio/dio.dart';
import 'package:pyc/data/clients/client_interface.dart';
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
}
