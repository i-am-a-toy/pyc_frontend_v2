import 'package:dio/dio.dart';

abstract class IAuthProvider {
  Future<Response> validateToken(String token);
  Future<Response> validateMyToken();
  Future<Response> login(String name, String password);
  Future<void> logout();
}
