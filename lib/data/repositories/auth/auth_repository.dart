import 'dart:developer';

import 'package:get/get.dart';
import 'package:pyc/data/models/common/responses/validation_response.dart';
import 'package:pyc/data/providers/auth/auth_provider_interface.dart';
import 'package:pyc/data/repositories/auth/auth_repository_interface.dart';

class AuthRepository extends GetxService implements IAuthRepository {
  final IAuthProvider provider;
  AuthRepository({required this.provider});

  /// validateToken
  ///
  /// description: Token을 입력받아 토큰이 유효한지 검증
  /// 토큰이 존재하지 않거나 Http Error가 발생할 경우 false값을 return
  @override
  Future<ValidationResponse> validateToken(String? token) async {
    try {
      if (token != null) {
        log('Token exist & Try validate');
        final response = await provider.validateToken(token);

        return ValidationResponse.fromJSON(response.data);
      }

      log('Token not exist');
      return ValidationResponse(false);
    } catch (e) {
      log('Fail validate token with $e');
      return ValidationResponse(false);
    }
  }

  @override
  Future<ValidationResponse> validateMyToken() async {
    try {
      final response = await provider.validateMyToken();
      return ValidationResponse.fromJSON(response.data);
    } catch (e) {
      log('Fail validate token with $e');
      return ValidationResponse(false);
    }
  }
}
