import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/controllers/calendar/calendar_controller.dart';
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
                // settings
                availableGestures: AvailableGestures.none, // for Scroll
                locale: locale,
                firstDay: firstDay,
                lastDay: lastDay,
                focusedDay: controller.focusDay,

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
      width: kDefaultValue * 1.5,
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
            width: kDefaultValue / 4,
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
