import 'package:dio/dio.dart';
import 'package:pyc/data/models/calendar/requests/create_calendar_request.dart';

abstract class ICalendarProvider {
  Future<Response> findById(int id);
  Future<Response> findByRange(DateTime start, DateTime end, {int offset = 0, int limit = 20});
  Future<Response> findDayEventsByMonth(int year, int month);
  Future<void> register(CreateCalendarRequest request);
}
