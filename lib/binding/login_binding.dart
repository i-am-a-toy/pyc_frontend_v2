import 'package:get/get.dart';
import 'package:pyc/controllers/login/login_controller.dart';
import 'package:pyc/data/repositories/auth/auth_repository.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    //service
    final authRepository = Get.find<AuthRepository>();

    //controller
    Get.put<LoginController>(
      LoginController(authRepository),
    );
  }
}
