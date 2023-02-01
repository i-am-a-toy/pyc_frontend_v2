import 'package:dio/dio.dart';

abstract class IAuthProvider {
  Future<Response> validateToken(String token);
}
