import 'package:pyc/data/models/calendar/requests/create_calendar_request.dart';
import 'package:pyc/data/models/calendar/responses/calendar_day_event_list_response.dart';
import 'package:pyc/data/models/calendar/responses/calendar_list_response.dart';
import 'package:pyc/data/models/calendar/responses/calendar_response.dart';
import 'package:pyc/data/providers/calendar/calendar_provider_interface.dart';
import 'package:pyc/data/repositories/calendar/calendar_repository_interface.dart';

class CalendarRepository implements ICalendarRepository {
  final ICalendarProvider provider;
  CalendarRepository(this.provider);

  @override
  Future<CalendarResponse> findById(int id) async {
    final response = await provider.findById(id);
    return CalendarResponse.fromJSON(response.data);
  }

  @override
  Future<CalendarListResponse> findByRange(DateTime start, DateTime end, {int offset = 0, int limit = 20}) async {
    final response = await provider.findByRange(start, end, offset: offset, limit: limit);
    return CalendarListResponse.fromJSON(response.data);
  }

  @override
  Future<CalendarDayEventListResponse> findDayEventsByMonth(int year, int month) async {
    final response = await provider.findDayEventsByMonth(year, month);
    return CalendarDayEventListResponse.fromJSON(response.data);
  }

  @override
  Future<void> register(CreateCalendarRequest request) async {
    await provider.register(request);
  }
}
