import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  // Calendar
  bool _isLoading = true;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _format = CalendarFormat.month;

  DateTime get focusedDay => _focusedDay;
  DateTime get selectedDay => _selectedDay;
  bool get isLoading => _isLoading;
  CalendarFormat get format => _format;

  /// Bottom Modal Sheet
  bool _isAllDay = true;
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now();

  bool get isAllDay => _isAllDay;
  DateTime get start => _start;
  DateTime get end => _end;

  /// Calendar

  /// onDaySelected
  ///
  /// @description: Calendar에서 날짜가 선택될 때 마다 호출되는 method
  /// 이로 인해 변경되는 값은 focus, selected, start, end 이다.
  /// start, end를 변경하는 이유는 BottomSheetModal에서 Init 값으로 사용하고 있기 때문이다.
  onDaySelected(DateTime selectDay, DateTime focusDay) {
    // if (isSameDay(selectedDay, focusDay)) return;
    log('[onDaySelected] Change select & focus: ${DateFormat('yyyy-MM-dd').format(_selectedDay)} to ${DateFormat('yyyy-MM-dd').format(selectDay)}');
    _selectedDay = selectDay;
    _focusedDay = selectDay;
    log('[onDaySelected] Change start & end: ${DateFormat('yyyy-MM-dd').format(_selectedDay)} to ${DateFormat('yyyy-MM-dd').format(selectDay)}');
    _start = selectDay;
    _end = selectDay;
    update();
  }

  /// onPageChanged
  ///
  /// @description: Calendar의 Header에 있는 Prev, Next 버튼이 눌릴 때 마다 호출된다.
  /// Format에 따라 인자로 들어오는 focusedDay가 다르며 들어온 데이터를 이용하여 _focused에 할당한다.
  /// https://github.com/aleksanderwozniak/table_calendar#updating-focusedday
  onPageChanged(DateTime focusedDay) {
    log('[onPageChanged] Change focus & focus: ${DateFormat('yyyy-MM-dd').format(_focusedDay)} to ${DateFormat('yyyy-MM-dd').format(focusedDay)}');
    _focusedDay = focusedDay;
  }

  /// onFormatChanged
  ///
  /// @description: Calendar Header에 있는 format 버튼이 클릭 될 때 마다 호출된다.
  /// Calendar의 보여지는 format을 변경시켜준다.
  onFormatChanged(CalendarFormat format) {
    _format = format;
    update();
  }

  /// Bottom Modal Sheet

  resetBottomSheet() {
    log('Reset Calendar Bottom Sheet State start, end with $_selectedDay');
    _start = _selectedDay;
    _end = _selectedDay;
    _isAllDay = true;
    update();
  }

  toggleIsAllDay(bool val) {
    _isAllDay = val;
    update();
  }

  onConfirmStart(DateTime? confirm) {
    if (confirm == null) return;

    _start = confirm;
    if (_end.isBefore(confirm)) _end = confirm;
    update();
  }

  onConfirmEnd(DateTime? confirm) {
    if (confirm == null) return;

    _end = confirm;
    update();
  }
}
