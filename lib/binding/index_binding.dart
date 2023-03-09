import 'package:get/get.dart';
import 'package:pyc/controllers/index/fetch_me_controller.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/data/clients/client.dart';
import 'package:pyc/data/providers/notice/notice_provider.dart';
import 'package:pyc/data/providers/user/user_provider.dart';
import 'package:pyc/data/repositories/auth/auth_repository.dart';
import 'package:pyc/data/repositories/notice/notice_repository.dart';
import 'package:pyc/data/repositories/user/user_repository.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    final client = DioClient();
    final authRepository = Get.find<AuthRepository>();
    final userRepository = Get.put<UserRepository>(UserRepository(UserProvider(client)));
    final noticeRepository = Get.put<NoticeRepository>(NoticeRepository(NoticeProvider(client)));

    Get.put<FetchMeController>(FetchMeController(userRepository, authRepository));
    Get.put<NoticeController>(NoticeController(noticeRepository));
  }
}
