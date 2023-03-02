import 'package:pyc/data/models/dto/creator/creator_dto.dart';
import 'package:pyc/data/models/dto/last_modifier/last_modifier_dto.dart';

class NoticeResponse {
  final int id;
  final String title;
  final String content;
  final CreatorDTO creator;
  final DateTime createdAt;
  final LastModifierDTO lastModifier;
  final DateTime lastModifiedAt;

  NoticeResponse(
    this.id,
    this.title,
    this.content,
    this.creator,
    this.createdAt,
    this.lastModifier,
    this.lastModifiedAt,
  );

  NoticeResponse.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        creator = CreatorDTO.fromJSON(json['creator'] as Map<String, dynamic>),
        createdAt = DateTime.parse(json['createdAt']),
        lastModifier = LastModifierDTO.fromJSON(json['lastModifier'] as Map<String, dynamic>),
        lastModifiedAt = DateTime.parse(json['lastModifiedAt']);

  static NoticeResponse init() {
    return NoticeResponse(
      1,
      "",
      "",
      CreatorDTO(1, "", ""),
      DateTime.now(),
      LastModifierDTO(1, "", ""),
      DateTime.now(),
    );
  }
}
