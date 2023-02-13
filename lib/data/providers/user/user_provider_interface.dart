import 'package:dio/dio.dart';

abstract class IUserProvider {
  Future<Response> fetchMe();
}
