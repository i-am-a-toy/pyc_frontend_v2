import 'package:dio/dio.dart';
import 'package:pyc/data/clients/client_interface.dart';
import 'package:pyc/data/models/notice/requests/create_notice_comment_request.dart';
import 'package:pyc/data/models/notice/requests/update_notice_comment_request.dart';
import 'package:pyc/data/providers/notice/notice_comment_provider_interface.dart';

class NoticeCommentProvider implements INoticeCommentProvider {
  final IClient<Dio> client;
  NoticeCommentProvider(this.client);

  @override
  Future<Response> comment(int noticeId, String comment) async {
    final authClient = await client.getAuthClient();
    return authClient.post(
      '/notice-comments/notices/$noticeId',
      data: CreateNoticeCommentRequest(comment).toJSON(),
    );
  }

  @override
  Future<Response> findAllByNoticeId(int noticeId, {int offset = 0, int limit = 20}) async {
    final authClient = await client.getAuthClient();
    return authClient.get(
      '/notice-comments/notices/$noticeId',
      queryParameters: {"offset": offset, "limit": limit},
    );
  }

  @override
  Future<Response> findById(int id) async {
    final authClient = await client.getAuthClient();
    return authClient.get('/notice-comments/$id');
  }

  @override
  Future<Response> modify(int id, String comment) async {
    final authClient = await client.getAuthClient();
    return authClient.put(
      '/notice-comments/$id',
      data: UpdateNoticeCommentRequest(comment).toJSON(),
    );
  }

  @override
  Future<void> deleteById(int id) async {
    final authClient = await client.getAuthClient();
    await authClient.delete('/notice-comments/$id');
  }
}
