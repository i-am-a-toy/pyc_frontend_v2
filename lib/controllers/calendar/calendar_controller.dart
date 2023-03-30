import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/utils/get_snackbar.dart';
import 'package:pyc/data/models/calendar/requests/create_calendar_request.dart';
import 'package:pyc/data/models/calendar/responses/calendar_list_response.dart';
import 'package:pyc/data/models/calendar/responses/calendar_response.dart';
import 'package:pyc/data/repositories/calendar/calendar_repository_interface.dart';
import 'package:pyc/extension/datetime.dart';
import 'package:pyc/screens/calendar/components/bottom_modal_sheet.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  final ICalendarRepository _calendarRepository;
  final ScrollController _scrollController = ScrollController();
  CalendarController(this._calendarRepository);

  /// Calendar
  bool _isCalendarLoading = true;
  bool _isDateLoading = true;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  /// Bottom Modal Sheet
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now();
  bool _isAllDay = true;

  /// API
  int _offset = 0;
  int _limit = 20;
  List<CalendarResponse> _dateRows = [];
  int _dateCount = 0;
  bool _dateHasMore = true;
  Map<DateTime, bool> _dayEventList = {};

  @override
  @mustCallSuper
  void onInit() async {
    super.onInit();
    _scrollController.addListener(_listener);

    await findDayEventsByMonth(_selectedDay.year, _selectedDay.month);
    await findCalendarsByDate(_selectedDay);
  }

  /// onDaySelected
  ///
  /// @description: Calendar에서 날짜가 선택될 때 마다 호출되는 method
  /// 이로 인해 변경되는 값은 focus, selected, start, end 이다.
  /// start, end를 변경하는 이유는 BottomSheetModal에서 Init 값으로 사용하고 있기 때문이다.
  Future<void> onDaySelected(DateTime selectDay, DateTime focusDay) async {
    if (isSameDay(selectDay, _selectedDay)) return;
    log('[onDaySelected] Change focus & focus: ${DateFormat('yyyy-MM-dd').format(_selectedDay)} to ${DateFormat('yyyy-MM-dd').format(selectDay)}');
    _offset = 0;
    _limit = 20;
    _selectedDay = selectDay;
    _focusedDay = selectDay;
    await findCalendarsByDate(selectDay);
    update();
  }

  /// onFormatChanged
  ///
  /// @description: Calendar Header에 있는 format 버튼이 클릭 될 때 마다 호출된다.
  /// Calendar의 보여지는 format을 변경시켜준다.
  onFormatChanged(CalendarFormat calendarFormat) {
    log('[onFormatChanged] Change calendarFormat: $_calendarFormat to $calendarFormat');
    _calendarFormat = calendarFormat;
    update();
  }

  /// onPageChanged
  ///
  /// @description: Calendar의 Header에 있는 Prev, Next 버튼이 눌릴 때 마다 호출된다.
  /// Format에 따라 인자로 들어오는 focusedDay가 다르며 들어온 데이터를 이용하여 _focused에 할당한다.
  /// https://github.com/aleksanderwozniak/table_calendar#updating-focusedday
  Future<void> onPageChanged(DateTime focusedDay) async {
    log('[onPageChanged] Change focus & focus: ${DateFormat('yyyy-MM-dd').format(_focusedDay)} to ${DateFormat('yyyy-MM-dd').format(focusedDay)}');
    _focusedDay = focusedDay;
    await findDayEventsByMonth(focusedDay.year, focusedDay.month);
  }

  /// getEventsForDay
  ///
  /// @description: 인자로 받는 날짜를 가지고 EventMap인 LinkedHashedMap에 Key값과 비교한다.
  /// 인자로 들어오는 DateTime의 TimeZone은 UTC Date가 들어온다.
  List<bool> getEventsForDay(DateTime day) {
    final isExist = _dayEventList[day];
    if (isExist == null) {
      return [];
    }

    return isExist ? [true] : [];
  }

  /// Bottom Modal Sheet
  openDetailBottomSheet(BuildContext context, bool isDetail, CalendarResponse data) {
    log('[openDetailBottomSheet] Open Detail BottomSheet');
    _start = data.start;
    _end = data.end;
    _selectedDay = data.start;
    _end = data.end;

    getBottomModal(context: context, isDetail: isDetail, data: data);
  }

  resetBottomSheet() {
    log('[resetBottomSheet] Reset BottomSheet State start, end with $_selectedDay');
    _start = _selectedDay;
    _end = _selectedDay;
    _isAllDay = true;
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

  toggleIsAllDay(bool val) {
    _isAllDay = val;
    update();
  }

  /// API
  Future<void> findCalendarsByDate(DateTime date) async {
    log('Hit findCalendarsByDate with date: $date');

    try {
      _isDateLoading = true;
      update();

      final start = date.dateOnly();
      final end = start.add(const Duration(days: 1));
      final response = await _findCalendarListByRange(start, end);

      _dateRows = response.rows;
      _dateCount = response.count;
      _dateHasMore = response.rows.length < response.count;
      _isDateLoading = false;
      update();
    } catch (e) {
      _handleError(e);
    }
  }

  /// findDayEventsByMonth
  ///
  /// description: 년, 월을 입력받아 해당 월의 이벤트 리스트를 조회하는 API
  Future<void> findDayEventsByMonth(int year, int month) async {
    log('[findDayEventsByMonth] with year: $year, month: $month');
    try {
      _isCalendarLoading = true;
      update();

      final response = await _calendarRepository.findDayEventsByMonth(year, month);
      _dayEventList = response.toEventListMap();
      _isCalendarLoading = false;
      update();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> registerCalendar(String title, String content) async {
    log('[registerCalendar] register with title: $title, content: $content, start: $_start, end: $_end, isAllDay: $_isAllDay');
    try {
      final request = CreateCalendarRequest(_start, _end, _isAllDay, title, content);
      await _calendarRepository.register(request);
      showGetXSnackBar('알림', '일정 등록에 성공했습니다.');
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _listener() async {
    if (_isDateLoading || !_dateHasMore) return;

    if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
      _dateHasMore = true;
      _offset += 20;
      _limit += 20;

      final start = _selectedDay.dateOnly();
      final end = _selectedDay.add(const Duration(days: 1));
      await Future.delayed(const Duration(microseconds: 500));

      final response = await _findCalendarListByRange(start, end, offset: _offset, limit: _limit);

      _dateRows.addAll(response.rows);
      _dateCount = response.count;
      _dateHasMore = _dateRows.length < _dateCount;
      update();
    }
  }

  Future<CalendarListResponse> _findCalendarListByRange(DateTime start, DateTime end, {int offset = 0, int limit = 20}) async {
    log('Hit findCalendarsByRange with start: $start, end: $end');
    return await _calendarRepository.findByRange(start, end, offset: offset, limit: limit);
  }

  void _handleError(Object e) {
    if (e is DioError) {
      _isCalendarLoading = false;
      _isDateLoading = false;
      update();

      // sever exception Message
      showGetXSnackBar('요청 실패', e.response!.data['message']);
      return;
    }

    // Internal Service Error or Flutter Error
    showGetXSnackBar('요청 실패', '서버에 문제가 있습니다.\n관리자에게 문의해주세요.');
  }

  DateTime get focusedDay => _focusedDay;
  DateTime get selectedDay => _selectedDay;
  bool get isCalendarLoading => _isCalendarLoading;
  bool get isDateLoading => _isDateLoading;
  CalendarFormat get calendarFormat => _calendarFormat;
  ScrollController get scrollController => _scrollController;

  List<CalendarResponse> get dateRows => _dateRows;
  int get dayCount => _dateCount;
  bool get dateHasMore => _dateHasMore;
  Map<DateTime, bool> get dayEventList => _dayEventList;

  bool get isAllDay => _isAllDay;
  DateTime get start => _start;
  DateTime get end => _end;
}
