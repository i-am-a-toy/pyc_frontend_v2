import 'package:pyc/data/models/notice/responses/notice_comment_list_response.dart';
import 'package:pyc/data/models/notice/responses/notice_comment_response.dart';

abstract class INoticeCommentRepository {
  // C
  Future<NoticeCommentResponse> comment(String comment);

  // R
  Future<NoticeCommentResponse> findById(int id);
  Future<NoticeCommentListResponse> findAllByNoticeId(int noticeId);

  // U
  Future<NoticeCommentResponse> modify(int id, String comment);

  // D
  Future<void> deleteById(int id);
}
