import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/validators/form/form_validator.dart';
import 'package:pyc/controllers/calendar/calendar_controller.dart';
import 'package:pyc/extension/datetime.dart';
import 'package:pyc/screens/calendar/components/date_form_field.dart';
import 'package:pyc/screens/components/input/default_border_input_field.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = '/calendars';
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime firstDay = DateTime(2022, 1, 1);
    final DateTime lastDay = DateTime(2099, 12, 31);
    const String locale = 'ko-KR';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            onPressed: () => _getBottomModal(context),
            icon: const Icon(
              CupertinoIcons.calendar_badge_plus,
              size: kDefaultValue * 1.5,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            kHeightSizeBox,
            GetBuilder<CalendarController>(
              builder: (controller) => TableCalendar(
                onDaySelected: controller.onDaySelected,
                selectedDayPredicate: (day) => isSameDay(controller.selectedDay, day),
                onPageChanged: controller.onPageChanged,
                onFormatChanged: controller.onFormatChanged,
                // settings
                availableGestures: AvailableGestures.none, // for Scroll
                locale: locale,
                firstDay: firstDay,
                lastDay: lastDay,
                focusedDay: controller.focusedDay,
                calendarFormat: controller.format,

                /// style
                /// days height
                daysOfWeekHeight: kDefaultValue * 2,

                /// Header
                headerStyle: getCalendarHeaderStyle(),

                /// Calendar
                calendarStyle: getCalendarStyle(),

                /// Calendar Builder
                calendarBuilders: CalendarBuilders(
                  dowBuilder: getDowBuilder,
                  markerBuilder: getMarkerBuilder,
                  selectedBuilder: getSelectedBuilder,
                  todayBuilder: getTodayBuilder,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getBottomModal(BuildContext context) {
    // Bottom Modal Sheet
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      /// Border Shape
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),

      builder: (context) {
        return Form(
          key: formKey,
          child: InkWell(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.75,
              child: GetBuilder<CalendarController>(
                builder: (controller) => SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    kDefaultValue,
                    kDefaultValue,
                    kDefaultValue,
                    MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              CupertinoIcons.clear_circled,
                              color: kPrimaryColor,
                              size: kDefaultValue * 1.5,
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () async {},
                            icon: const Icon(
                              CupertinoIcons.check_mark_circled,
                              color: kPrimaryColor,
                              size: kDefaultValue * 1.5,
                            ),
                          ),
                        ],
                      ),
                      kDoubleHeightSizeBox,
                      const Text(
                        'Title',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      kHalfHeightSizeBox,
                      DefaultBorderInputField(
                        maxLine: 2,
                        maxLength: 200,
                        autoFocus: true,
                        hintText: 'Please enter a title...',
                        onSaved: (val) {},
                        validate: requiredStringValidator,
                      ),
                      kHeightSizeBox,
                      const Text(
                        'Content',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      kHalfHeightSizeBox,
                      DefaultBorderInputField(
                        maxLine: 5,
                        hintText: 'Please enter a content...',
                        onSaved: (val) {},
                        validate: requiredStringValidator,
                      ),
                      kHeightSizeBox,

                      /// isAllDay switch
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'All Day',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value: controller.isAllDay,
                            onChanged: controller.toggleIsAllDay,
                            activeColor: kPrimaryColor,
                          ),
                        ],
                      ),
                      kHeightSizeBox,
                      DateFormFiled(
                        context: context,
                        onConfirm: controller.onConfirmStart,
                        initialValue: controller.start,
                        isAllDay: controller.isAllDay,
                        title: '시작',
                      ),
                      kHeightSizeBox,
                      DateFormFiled(
                        context: context,
                        minTime: controller.start,
                        onConfirm: controller.onConfirmEnd,
                        initialValue: controller.end,
                        isAllDay: controller.isAllDay,
                        title: '종료',
                        validator: (value) => controller.end.isAfterOrEqualTo(value!) ? null : '종료는 시작과 같거나 이 후 시점이여야 합니다.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).whenComplete(
      () => Get.find<CalendarController>().resetBottomSheet(),
    );
  }

  Widget? getTodayBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    return Container(
      width: kDefaultValue * 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.amber.shade700,
        shape: BoxShape.circle,
      ),
      child: Text(
        day.day.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget? getSelectedBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    return Container(
      width: kDefaultValue * 2,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        shape: BoxShape.circle,
      ),
      child: Text(
        day.day.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget? getMarkerBuilder(
    BuildContext context,
    DateTime day,
    List<Object?> events,
  ) {
    return events.isNotEmpty
        ? Container(
            width: kDefaultValue / 2,
            height: kDefaultValue / 2,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
          )
        : null;
  }

  Widget? getDowBuilder(BuildContext context, DateTime day) {
    switch (day.weekday) {
      case DateTime.monday:
        return const Center(
          child: Text('월'),
        );
      case DateTime.tuesday:
        return const Center(
          child: Text('화'),
        );
      case DateTime.wednesday:
        return const Center(
          child: Text('수'),
        );
      case DateTime.thursday:
        return const Center(
          child: Text('목'),
        );
      case DateTime.friday:
        return const Center(
          child: Text('금'),
        );
      case DateTime.saturday:
        return const Center(
          child: Text(
            '토',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      default:
        return const Center(
          child: Text(
            '일',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
    }
  }

  CalendarStyle getCalendarStyle() {
    return CalendarStyle(
      isTodayHighlighted: true,
      selectedDecoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: kPrimaryColor,
      ),
      defaultTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      markersAlignment: Alignment.bottomCenter,
      canMarkersOverflow: false,
      holidayTextStyle: TextStyle(color: Colors.red.shade700),
    );
  }

  HeaderStyle getCalendarHeaderStyle() {
    return HeaderStyle(
      /// format button
      formatButtonVisible: true,
      formatButtonDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultValue),
        color: Colors.amber.shade700,
        border: Border.all(
          color: Colors.amber.shade700,
          width: 2.0,
        ),
      ),
      formatButtonShowsNext: false,
      formatButtonTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      ),

      /// title
      titleTextStyle: const TextStyle(
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),

      /// chevron Button
      leftChevronIcon: const Icon(
        Icons.chevron_left_outlined,
        color: kPrimaryColor,
        size: kDefaultValue * 2,
      ),
      rightChevronIcon: const Icon(
        Icons.chevron_right_outlined,
        color: kPrimaryColor,
        size: kDefaultValue * 2,
      ),
    );
  }
}
