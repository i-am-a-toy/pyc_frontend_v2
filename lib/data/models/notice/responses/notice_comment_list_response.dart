import 'package:pyc/data/models/notice/responses/notice_comment_response.dart';

class NoticeCommentListResponse {
  final List<NoticeCommentResponse> rows;
  final int count;

  NoticeCommentListResponse({required this.rows, required this.count});

  NoticeCommentListResponse.fromJSON(Map<String, dynamic> json)
      : rows = (json['rows'] as List<dynamic>).map((e) => NoticeCommentResponse.fromJSON(e)).toList(),
        count = json['count'];
}
