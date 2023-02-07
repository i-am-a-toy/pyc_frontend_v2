import 'dart:developer';

import 'package:get/get.dart';
import 'package:pyc/data/models/auth/responses/token_response.dart';
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

  /// login
  ///
  /// 사용자에게 이름과 비밀번호를 입력받아 로그인을 요청한다.
  /// 요청 후 ResponseBody를 TokenResponse로 변환
  @override
  Future<TokenResponse> login(String name, String password) async {
    final response = await provider.login(name, password);
    return TokenResponse.fromJSON(response.data);
  }
}
