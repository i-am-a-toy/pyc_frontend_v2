import 'package:dio/dio.dart';

abstract class INoticeCommentProvider {
  // C
  Future<Response> comment(String comment);

  // R
  Future<Response> findById(int id);
  Future<Response> findAllByNoticeId(int noticeId, {int offset, int limit});

  // U
  Future<Response> modify(int id, String comment);

  // D
  Future<void> deleteById(int id);
}
