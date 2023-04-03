import 'package:pyc/data/models/dto/calendar/day_event_dto.dart';

class CalendarDayEventListResponse {
  final List<DayEventDTO> rows;
  final int count;

  CalendarDayEventListResponse(this.rows, this.count);

  CalendarDayEventListResponse.fromJSON(Map<String, dynamic> json)
      : rows = (json['rows'] as List<dynamic>).map((e) => DayEventDTO.fromJSON(e)).toList(),
        count = json['count'];

  Map<DateTime, bool> toEventListMap() {
    final dayEventsMap = <DateTime, bool>{};
    for (var e in rows) {
      final dayEvent = <DateTime, bool>{e.day: e.isExist};
      dayEventsMap.addAll(dayEvent);
    }
    return dayEventsMap;
  }
}
