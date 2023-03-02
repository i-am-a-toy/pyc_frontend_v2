import 'package:pyc/data/models/notice/responses/notice_comment_list_response.dart';
import 'package:pyc/data/models/notice/responses/notice_comment_response.dart';
import 'package:pyc/data/providers/notice/notice_comment_provider_interface.dart';
import 'package:pyc/data/repositories/notice/notice_comment_repository_interface.dart';

class NoticeCommentRepository implements INoticeCommentRepository {
  final INoticeCommentProvider provider;
  NoticeCommentRepository(this.provider);

  @override
  Future<NoticeCommentResponse> comment(int noticeId, String comment) async {
    final response = await provider.comment(noticeId, comment);
    return NoticeCommentResponse.fromJSON(response.data);
  }

  @override
  Future<NoticeCommentListResponse> findAllByNoticeId(int noticeId, {int offset = 0, int limit = 20}) async {
    final response = await provider.findAllByNoticeId(noticeId, offset: offset, limit: limit);
    return NoticeCommentListResponse.fromJSON(response.data);
  }

  @override
  Future<NoticeCommentResponse> findById(int id) async {
    final response = await provider.findById(id);
    return NoticeCommentResponse.fromJSON(response.data);
  }

  @override
  Future<NoticeCommentResponse> modify(int id, String comment) async {
    final response = await provider.modify(id, comment);
    return NoticeCommentResponse.fromJSON(response.data);
  }

  @override
  Future<void> deleteById(int id) async {
    await provider.deleteById(id);
  }
}
