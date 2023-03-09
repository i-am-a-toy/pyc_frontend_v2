import 'package:dio/dio.dart';
import 'package:pyc/data/clients/client_interface.dart';
import 'package:pyc/data/models/notice/requests/create_notice_request.dart';
import 'package:pyc/data/providers/notice/notice_provider_interface.dart';

class NoticeProvider implements INoticeProvider {
  final IClient<Dio> client;
  NoticeProvider(this.client);

  @override
  Future<void> write(String title, String content) async {
    final authClient = await client.getAuthClient();
    await authClient.post(
      '/notices',
      data: CreateNoticeRequest(title, content).toJSON(),
    );
  }

  @override
  Future<Response> findAll({int offset = 0, int limit = 20}) async {
    final authClient = await client.getAuthClient();
    return authClient.get(
      '/notices',
      queryParameters: {"offset": offset, "limit": limit},
    );
  }

  @override
  Future<Response> findById(int id) async {
    final authClient = await client.getAuthClient();
    return authClient.get('/notices/$id');
  }

  @override
  Future<void> modify(int id, String title, String content) async {
    final authClient = await client.getAuthClient();
    await authClient.put(
      '/notices/$id',
      data: CreateNoticeRequest(title, content).toJSON(),
    );
  }

  @override
  Future<void> deleteById(int id) async {
    final authClient = await client.getAuthClient();
    await authClient.delete('/notices/$id');
  }
}
