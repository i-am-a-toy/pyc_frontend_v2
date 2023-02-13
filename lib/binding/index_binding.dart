import 'package:get/get.dart';
import 'package:pyc/controllers/index/fetch_me_controller.dart';
import 'package:pyc/data/clients/client.dart';
import 'package:pyc/data/providers/user/user_provider.dart';
import 'package:pyc/data/repositories/user/user_repository.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    final userRepository = Get.put<UserRepository>(
      UserRepository(
        UserProvider(DioClient()),
      ),
    );
    Get.put<FetchMeController>(FetchMeController(userRepository));
  }
}
