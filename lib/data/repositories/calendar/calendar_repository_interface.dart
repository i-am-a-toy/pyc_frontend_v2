import 'package:pyc/data/models/calendar/requests/create_calendar_request.dart';
import 'package:pyc/data/models/calendar/responses/calendar_day_event_list_response.dart';
import 'package:pyc/data/models/calendar/responses/calendar_list_response.dart';
import 'package:pyc/data/models/calendar/responses/calendar_response.dart';

abstract class ICalendarRepository {
  Future<CalendarResponse> findById(int id);
  Future<CalendarListResponse> findByRange(DateTime start, DateTime end, {int offset = 0, int limit = 20});
  Future<CalendarDayEventListResponse> findDayEventsByMonth(int year, int month);
  Future<void> register(CreateCalendarRequest request);
}
