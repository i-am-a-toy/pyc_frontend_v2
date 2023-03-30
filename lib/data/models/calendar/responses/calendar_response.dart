import 'package:pyc/data/models/dto/creator/creator_dto.dart';
import 'package:pyc/data/models/dto/last_modifier/last_modifier_dto.dart';

class CalendarResponse {
  final DateTime start;
  final DateTime end;
  final bool isAllDay;
  final String title;
  final String content;
  final CreatorDTO creator;
  final DateTime createdAt;
  final LastModifierDTO lastModifier;
  final DateTime lastModifiedAt;

  CalendarResponse(
      this.start, this.end, this.isAllDay, this.title, this.content, this.creator, this.createdAt, this.lastModifier, this.lastModifiedAt);

  CalendarResponse.fromJSON(Map<String, dynamic> json)
      : start = DateTime.parse(json['start']).add(const Duration(hours: 9)),
        end = DateTime.parse(json['end']).add(const Duration(hours: 9)),
        isAllDay = json['isAllDay'],
        title = json['title'],
        content = json['content'],
        creator = CreatorDTO.fromJSON(json['creator']),
        createdAt = DateTime.parse(json['createdAt']).add(const Duration(hours: 9)),
        lastModifier = LastModifierDTO.fromJSON(json['lastModifier']),
        lastModifiedAt = DateTime.parse(json['lastModifiedAt']).add(const Duration(hours: 9));

  static CalendarResponse init() {
    return CalendarResponse(
      DateTime.now(),
      DateTime.now(),
      false,
      '',
      '',
      CreatorDTO(1, "", ""),
      DateTime.now(),
      LastModifierDTO(1, "", ""),
      DateTime.now(),
    );
  }
}
