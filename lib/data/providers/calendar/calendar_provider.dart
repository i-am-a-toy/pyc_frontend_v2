import 'package:dio/dio.dart';
import 'package:pyc/data/clients/client.dart';
import 'package:pyc/data/clients/client_interface.dart';
import 'package:pyc/data/models/calendar/requests/create_calendar_request.dart';
import 'package:pyc/data/providers/calendar/calendar_provider_interface.dart';

class CalendarProvider implements ICalendarProvider {
  late IClient<Dio> client;

  CalendarProvider() {
    client = DioClient();
  }

  @override
  Future<Response> findById(int id) async {
    final authClient = await client.getAuthClient();
    return await authClient.get('/calendars/$id');
  }

  @override
  Future<Response> findByRange(DateTime start, DateTime end, {int offset = 0, int limit = 20}) async {
    final authClient = await client.getAuthClient();
    return await authClient.get(
      '/calendars',
      queryParameters: {
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
        'offset': offset,
        'limit': limit,
      },
    );
  }

  @override
  Future<Response> findDayEventsByMonth(int year, int month) async {
    final authClient = await client.getAuthClient();
    return await authClient.get('/calendars/year/$year/month/$month/events');
  }

  @override
  Future<void> register(CreateCalendarRequest request) async {
    final authClient = await client.getAuthClient();
    await authClient.post('/calendars', data: request.toJson());
  }
}
