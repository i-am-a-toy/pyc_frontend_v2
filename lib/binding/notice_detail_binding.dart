import 'package:get/get.dart';
import 'package:pyc/controllers/notice/notice_comment_controller.dart';
import 'package:pyc/controllers/notice/notice_detail_controller.dart';
import 'package:pyc/data/clients/client.dart';
import 'package:pyc/data/providers/notice/notice_comment_provider.dart';
import 'package:pyc/data/repositories/notice/notice_comment_repository.dart';
import 'package:pyc/data/repositories/notice/notice_repository.dart';

class NoticeDetailBinding extends Bindings {
  @override
  void dependencies() {
    final int noticeId = Get.arguments['id'] as int;

    // Notice
    Get.put<NoticeDetailController>(
      NoticeDetailController(
        Get.find<NoticeRepository>(),
        noticeId,
      ),
    );

    // NoticeComment
    final noticeRepository = Get.put(
      NoticeCommentRepository(
        NoticeCommentProvider(
          DioClient(),
        ),
      ),
    );
    Get.put<NoticeCommentController>(
      NoticeCommentController(noticeRepository, noticeId),
    );
  }
}
