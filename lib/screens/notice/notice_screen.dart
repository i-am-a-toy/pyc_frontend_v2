import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/screens/components/button/default_app_bar_back_button.dart';

// TODO: Notice Screen 구현하기
class NoticeScreen extends StatelessWidget {
  static const routeName = '/notices';
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const int toIndex = 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notices'),
        leading: DefaultAppBarBackButton(
          onPressed: () async {
            Get.find<NoticeController>().refetch();
            Get.close(toIndex);
          },
        ),
      ),
    );
  }
}
