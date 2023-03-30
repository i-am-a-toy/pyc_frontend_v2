import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/controllers/calendar/calendar_controller.dart';
import 'package:pyc/data/models/calendar/responses/calendar_response.dart';
import 'package:pyc/extension/datetime.dart';
import 'package:pyc/screens/calendar/components/bottom_modal_sheet.dart';
import 'package:pyc/screens/components/avatar/default_avatar_content.dart';
import 'package:pyc/screens/components/avatar/default_circle_avatar.dart';
import 'package:pyc/screens/components/calendar/default_table_calendar.dart';

/// CalendarScreen
///
/// * @description: CalendarScreen이 StatefulWidget인 이유는 LifeCycle을 이용하기 위함.
/// * Index에서 Calendar로 넘어올 때 CalendarScreen의 BuildContext를 이용하기 위해서
/// * GetX Argument로 isDetail과 Data가 넘어오면 해당 Data를 이용하여 BottomModalSheet를 띄운다.
class CalendarScreen extends StatefulWidget {
  static const routeName = '/calendars';
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bool? isDetail = Get.arguments?['isDetail'];
      CalendarResponse? data = Get.arguments?['data'];

      /// * isDeTail이 존재하고 isDetail이 True일 경우에만 BottomModalSheet를 통해 Detail을 보여준다.
      if (isDetail != null && isDetail) {
        Get.find<CalendarController>().openDetailBottomSheet(context, isDetail, data!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final CalendarController calendarController = Get.find<CalendarController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            onPressed: () {
              getBottomModal(
                context: context,
                isDetail: false,
                onCloseTap: () => Navigator.of(context).pop(),
                onRegisterTap: calendarController.registerCalendar,
              );
            },
            icon: const Icon(CupertinoIcons.calendar_badge_plus),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultValue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHalfHeightSizeBox,
            GetBuilder<CalendarController>(
              builder: (controller) => DefaultTableCalendar(
                locale: 'ko-KR',
                firstDay: DateTime(2022, 1, 1),
                lastDay: DateTime(2099, 12, 31),
                focusedDay: controller.focusedDay,
                selectedDay: controller.selectedDay,
                onDaySelected: controller.onDaySelected,
                onFormatChanged: controller.onFormatChanged,
                calendarFormat: controller.calendarFormat,
                onPageChanged: controller.onPageChanged,
                eventLoader: controller.getEventsForDay,
              ),
            ),
            kDoubleHeightSizeBox,
            const Text(
              'Events',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            kHeightSizeBox,
            Expanded(
              child: GetBuilder<CalendarController>(
                builder: (controller) => ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  itemCount: controller.dateRows.length + 1,
                  itemBuilder: (context, index) {
                    if (index < controller.dateRows.length) {
                      return Column(
                        children: [
                          CalendarCard(
                            onTap: () {},
                            title: controller.dateRows[index].title,
                            content: controller.dateRows[index].content,
                            subContext: controller.dateRows[index].isAllDay
                                ? '\n${controller.dateRows[index].start.toMMDD()} ~ ${controller.dateRows[index].end.toMMDD()}'
                                : '\n${controller.dateRows[index].start.toMMDDHHmm()} ~ ${controller.dateRows[index].end.toMMDDHHmm()}',
                          ),
                          if (controller.dateRows.length > index) kHeightSizeBox,
                        ],
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: kDefaultValue,
                        ),
                        child: CalendarDateListNoContent(
                          content: controller.dateHasMore ? '' : '추가적인 일정이 없습니다.',
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarCard extends StatelessWidget {
  final String title;
  final String content;
  final String? subContext;
  final VoidCallback onTap;

  const CalendarCard({
    super.key,
    required this.title,
    required this.content,
    required this.onTap,
    this.subContext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 80.0),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(kDefaultValue),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: DefaultAvatarContent(
                avatar: const DefaultCircleAvatar(
                  child: Icon(CupertinoIcons.calendar, color: Colors.white, size: kDefaultValue * 1.5),
                ),
                title: title,
                content: content,
                overflow: true,
                subContent: subContext,
                suffix: GestureDetector(
                  onTap: onTap,
                  child: const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: kDefaultValue * 2,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarDateListNoContent extends StatelessWidget {
  final String content;

  const CalendarDateListNoContent({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(
      builder: (controller) => Center(
        child: controller.dateHasMore
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
