import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/controllers/index/fetch_me_controller.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/screens/components/button/default_app_bar_back_button.dart';
import 'package:pyc/screens/notice/components/notice_card.dart';
import 'package:pyc/screens/notice/notice_detail_screen.dart';
import 'package:pyc/screens/notice/notice_write_screen.dart';

class NoticeScreen extends StatelessWidget {
  static const routeName = '/notices';
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const int toIndex = 1;
    final fetchMeController = Get.find<FetchMeController>();
    final noticeController = Get.find<NoticeController>();

    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: const Text('Notices'),
        leading: DefaultAppBarBackButton(
          onPressed: () async {
            await noticeController.refetch();
            Get.close(toIndex);
          },
        ),
        // Notice register only manager
        actions: fetchMeController.myProfile.role.isManager()
            ? [
                IconButton(
                  onPressed: () => Get.toNamed(NoticeWriteScreen.routeName),
                  icon: const Icon(Icons.edit_outlined),
                ),
              ]
            : null,
      ),
      body: RefreshIndicator(
        color: kPrimaryColor,
        onRefresh: () async => await Get.find<NoticeController>().refetch(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultValue,
          ),
          child: Column(
            children: [
              kHeightSizeBox,
              GetBuilder<NoticeController>(
                builder: (controller) {
                  /// isLoading
                  if (controller.isLoading) {
                    return const Expanded(
                        child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ));
                  }

                  /// noContent
                  if (controller.count == 0) {
                    return const Expanded(
                      child: NoticeListNoContent(
                        content: '등록된 공지사항이 없습니다.',
                      ),
                    );
                  }

                  /// notice list
                  return Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(), // for refresh indicator
                      shrinkWrap: true,
                      controller: controller.scrollController,
                      itemCount: controller.rows.length + 1,
                      itemBuilder: (context, index) {
                        if (index < controller.rows.length) {
                          return Column(
                            children: [
                              NoticeCard(
                                title: controller.rows[index].title,
                                writerName: controller.rows[index].creator.name,
                                content: controller.rows[index].content,
                                createdAt: controller.rows[index].createdAt,
                                cardTap: () => Get.toNamed(
                                  NoticeDetailScreen.routeName,
                                  arguments: {"id": controller.rows[index].id},
                                ),
                                buttonTap: () => Get.toNamed(
                                  NoticeDetailScreen.routeName,
                                  arguments: {
                                    "id": controller.rows[index].id,
                                    "autoFocus": true,
                                  },
                                ),
                              ),
                              kHeightSizeBox,
                            ],
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: kDefaultValue,
                            ),
                            child: NoticeListNoContent(
                              content: controller.isLoading ? '' : '추가적인 공지사항이 없습니다.',
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoticeListNoContent extends StatelessWidget {
  final String content;
  const NoticeListNoContent({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeController>(
      builder: (controller) => Center(
        child: Get.find<NoticeController>().hasMore
            ? const CircularProgressIndicator(
                color: kPrimaryColor,
              )
            : Text(
                content,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 14.0,
                ),
              ),
      ),
    );
  }
}
