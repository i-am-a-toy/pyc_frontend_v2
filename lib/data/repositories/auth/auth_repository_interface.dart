import 'package:pyc/data/models/auth/responses/token_response.dart';
import 'package:pyc/data/models/common/responses/validation_response.dart';

abstract class IAuthRepository {
  Future<ValidationResponse> validateToken(String? token);
  Future<ValidationResponse> validateMyToken();
  Future<TokenResponse> login(String name, String password);
}
