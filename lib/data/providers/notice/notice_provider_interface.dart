import 'package:dio/dio.dart';

abstract class INoticeProvider {
  // C
  Future<void> write(String title, String content);

  // R
  Future<Response> findById(int id);
  Future<Response> findAll({int offset, int limit});

  // U
  Future<void> modify(int id, String title, String content);

  // D
  Future<void> deleteById(int id);
}
