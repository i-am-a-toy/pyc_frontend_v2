import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/controllers/index/fetch_me_controller.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/extension/datetime.dart';
import 'package:pyc/screens/calendar/calendar_screen.dart';
import 'package:pyc/screens/components/layout/labeled_content.dart';
import 'package:pyc/screens/index/components/index_content.dart';
import 'package:pyc/screens/index/components/index_drawer.dart';
import 'package:pyc/screens/index/components/index_profile.dart';
import 'package:pyc/screens/notice/notice_detail_screen.dart';
import 'package:pyc/screens/notice/notice_screen.dart';

class IndexScreen extends StatelessWidget {
  static String routeName = '/index';
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image.asset('assets/icons/index_hamburger.png'),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: GetBuilder<FetchMeController>(
        builder: (controller) => IndexDrawer(
          name: controller.myProfile.name,
          size: MediaQuery.of(context).size,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<FetchMeController>(
              builder: (controller) => controller.isLoading
                  ? const ShimmerIndexUserProfile()
                  : IndexProfile(
                      image: controller.myProfile.image,
                      name: controller.myProfile.name,
                      role: controller.myProfile.role.displayName,
                    ),
            ),
            kHeightSizeBox,
            const _IndexNoticeList(),
            kHeightSizeBox,
            const _IndexCalendarList(),
          ],
        ),
      ),
    );
  }
}

class _IndexCalendarList extends StatelessWidget {
  const _IndexCalendarList({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LabeledContent(
      label: '일정',
      onTap: () => Get.toNamed(CalendarScreen.routeName),
      content: const IndexContent(
        icon: Icons.calendar_month_outlined,
        content: '이번 주 일정이 없습니다.',
        subContent: '일정을 등록해주세요.',
      ),
    );
  }
}

class _IndexNoticeList extends StatelessWidget {
  const _IndexNoticeList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeController>(builder: (controller) {
      const int rangeLimit = 3;
      final int range = controller.rows.length < rangeLimit ? controller.rows.length : rangeLimit;

      return LabeledContent(
        onTap: () async {
          await controller.refetch();
          Get.toNamed(NoticeScreen.routeName);
        },
        label: '공지사항',
        content: controller.count == 0 || controller.isLoading
            ? const IndexContent(
                icon: Icons.campaign_outlined,
                content: '등록된 공지사항이 없습니다.',
                subContent: '공지사항을 등록해주세요.',
              )
            : Column(
                children: [
                  for (int i = 0; i < range; i++)
                    IndexContent(
                      icon: Icons.campaign_outlined,
                      content: controller.rows[i].title,
                      subContent: '작성자 | ${controller.rows[i].creator.name} - ${controller.rows[i].createdAt.getDifferenceNow()}',
                      onTap: () => Get.toNamed(
                        NoticeDetailScreen.routeName,
                        arguments: {'id': controller.rows[i].id},
                      ),
                    ),
                ],
              ),
      );
    });
  }
}
