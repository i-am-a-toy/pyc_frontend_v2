import 'package:pyc/data/models/calendar/responses/calendar_response.dart';

class CalendarListResponse {
  final List<CalendarResponse> rows;
  final int count;

  CalendarListResponse(this.rows, this.count);

  CalendarListResponse.fromJSON(Map<String, dynamic> json)
      : rows = (json['rows'] as List<dynamic>).map((e) => CalendarResponse.fromJSON(e)).toList(),
        count = json['count'];
}
