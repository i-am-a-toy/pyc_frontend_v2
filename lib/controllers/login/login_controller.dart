import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pyc/common/utils/get_snackbar.dart';
import 'package:pyc/data/repositories/auth/auth_repository.dart';
import 'package:pyc/screens/index/index_screen.dart';

class LoginController extends GetxController {
  final AuthRepository repository;
  LoginController(this.repository);

  bool obscureText = true;
  IconData obscureIcon = Icons.visibility_off_outlined;

  void toggleObscureText() {
    obscureText = !obscureText;
    obscureIcon = obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    update();
  }

  Future<void> login(String name, String password) async {
    try {
      final tokenResponse = await repository.login(name, password);

      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: tokenResponse.accessToken);
      await storage.write(key: 'refresh', value: tokenResponse.refreshToken);

      Get.offAndToNamed(IndexScreen.routeName);
    } catch (e) {
      _handleLoginError((e as DioError).response?.statusCode ?? HttpStatus.internalServerError);
    }
  }

  void _handleLoginError(int statusCode) {
    switch (statusCode) {
      case HttpStatus.unauthorized:
        showGetXSnackBar('알림', '비밀번호가 틀립니다.');
        return;
      case HttpStatus.forbidden:
        showGetXSnackBar('알림', '로그인에 대한 권한이 충분하지 않습니다.');
        return;
      case HttpStatus.notFound:
        showGetXSnackBar('알림', '등록되어 있지 않은 유저 입니다.');
        return;
      default:
        showGetXSnackBar('알림', '서버에 문제가 있습니다. 관리자에게 문의해주세요.');
    }
  }
}
