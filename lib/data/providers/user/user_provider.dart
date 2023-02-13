import 'package:dio/dio.dart';
import 'package:pyc/data/clients/client_interface.dart';
import 'package:pyc/data/providers/user/user_provider_interface.dart';

class UserProvider implements IUserProvider {
  final IClient<Dio> client;
  UserProvider(this.client);

  @override
  Future<Response> fetchMe() async {
    final authClient = await client.getAuthClient();
    return authClient.get('/users/me');
  }
}
