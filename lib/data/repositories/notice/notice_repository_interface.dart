import 'package:pyc/data/models/notice/responses/notice_list_response.dart';
import 'package:pyc/data/models/notice/responses/notice_response.dart';

abstract class INoticeRepository {
  // C
  Future<void> write(String title, String content);

  // R
  Future<NoticeResponse> findById(int id);
  Future<NoticeListResponse> findAll({int offset, int limit});

  // U
  Future<void> modify(int id, String title, String content);

  // D
  Future<void> deleteById(int id);
}
