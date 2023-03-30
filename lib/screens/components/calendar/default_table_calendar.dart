import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/screens/calendar/theme/table_calendar_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class DefaultTableCalendar extends StatelessWidget {
  final String locale;
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final CalendarFormat? calendarFormat;
  final void Function(DateTime, DateTime)? onDaySelected;
  final void Function(CalendarFormat)? onFormatChanged;
  final void Function(DateTime)? onPageChanged;
  final List<Object?> Function(DateTime)? eventLoader;

  const DefaultTableCalendar({
    super.key,
    required this.locale,
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
    this.eventLoader,
    this.calendarFormat,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      // Calendar Setting
      availableGestures: AvailableGestures.none, // for scroll
      locale: locale,
      focusedDay: focusedDay,
      firstDay: firstDay,
      lastDay: lastDay,
      calendarFormat: calendarFormat != null ? calendarFormat! : CalendarFormat.month,

      // style
      /// days height
      daysOfWeekHeight: kDefaultValue * 2,

      /// Header
      headerStyle: getCalendarHeaderStyle(),

      /// Calendar
      calendarStyle: getCalendarStyle(),

      /// Calendar Builder
      calendarBuilders: const CalendarBuilders(
        dowBuilder: getDowBuilder,
        markerBuilder: getMarkerBuilder,
        selectedBuilder: getSelectedBuilder,
        todayBuilder: getTodayBuilder,
      ),

      /// interaction
      onDaySelected: onDaySelected,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onFormatChanged: onFormatChanged,
      onPageChanged: onPageChanged,
      eventLoader: eventLoader,
    );
    //   return TableCalendar(
    //     onDaySelected: controller.onDaySelected,
    //     selectedDayPredicate: (day) => isSameDay(controller.selectedDay, day),
    //     onPageChanged: controller.onPageChanged,
    //     onFormatChanged: controller.onFormatChanged,
    //     // settings
    //     availableGestures: AvailableGestures.none, // for Scroll
    //     locale: locale,
    //     firstDay: firstDay,
    //     lastDay: lastDay,
    //     focusedDay: controller.focusedDay,
    //     calendarFormat: controller.format,
    //     eventLoader: controller.getEventsForDay,

    //     /// style
    //     /// days height
    //     daysOfWeekHeight: kDefaultValue * 2,

    //     /// Header
    //     headerStyle: getCalendarHeaderStyle(),

    //     /// Calendar
    //     calendarStyle: getCalendarStyle(),

    //     /// Calendar Builder
    //     calendarBuilders: const CalendarBuilders(
    //       dowBuilder: getDowBuilder,
    //       markerBuilder: getMarkerBuilder,
    //       selectedBuilder: getSelectedBuilder,
    //       todayBuilder: getTodayBuilder,
    //     ),
    //   );
    // }
  }
}
