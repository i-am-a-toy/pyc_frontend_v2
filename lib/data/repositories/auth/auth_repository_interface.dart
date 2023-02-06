import 'package:pyc/data/models/common/responses/validation_response.dart';

abstract class IAuthRepository {
  Future<ValidationResponse> validateToken(String? token);
  Future<ValidationResponse> validateMyToken();
}
