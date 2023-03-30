import 'package:pyc/extension/datetime.dart';

class CreateCalendarRequest {
  final DateTime _start;
  final DateTime _end;
  final bool _isAllDay;
  final String _title;
  final String _content;

  CreateCalendarRequest(this._start, this._end, this._isAllDay, this._title, this._content);

  Map<String, dynamic> toJson() {
    return {
      'start': _isAllDay ? _start.dateOnly().toIso8601String() : _start.toIso8601String(),
      'end': _isAllDay ? _end.dateOnly().toIso8601String() : _end.toIso8601String(),
      'isAllDay': _isAllDay,
      'title': _title.replaceAll('\n', ' '),
      'content': _content.trim(),
    };
  }
}
