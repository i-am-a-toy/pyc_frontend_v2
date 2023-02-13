import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/utils/get_snackbar.dart';
import 'package:pyc/data/models/user/response/user_response.dart';
import 'package:pyc/data/repositories/user/user_repository_interface.dart';
import 'package:pyc/screens/login/login_screen.dart';

class FetchMeController extends GetxController {
  final IUserRepository repository;
  FetchMeController(this.repository);

  bool _isLoading = true;
  UserResponse _myProfile = UserResponse.init();

  @override
  @mustCallSuper
  void onInit() async {
    super.onInit();
    try {
      _myProfile = await repository.fetchMe();
      _isLoading = false;
      update();
    } catch (e) {
      log('Could not fetch myProfile error $e');
      Get.offAllNamed(LoginScreen.routeName);
      showGetXSnackBar('알림', '프로필을 불러오는데 실패하였습니다.');
    }
  }

  bool get isLoading => _isLoading;
  UserResponse get myProfile => _myProfile;
}
