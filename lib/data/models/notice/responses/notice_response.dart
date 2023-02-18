import 'package:pyc/data/models/dto/creator/creator_dto.dart';
import 'package:pyc/data/models/dto/last_modifier/last_modifier_dto.dart';

class NoticeResponse {
  final int id;
  final String title;
  final String content;
  final CreatorDTO creator;
  final LastModifierDTO lastModifier;

  NoticeResponse(
    this.id,
    this.title,
    this.content,
    this.creator,
    this.lastModifier,
  );

  NoticeResponse.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        creator = CreatorDTO.fromJSON(json['creator'] as Map<String, dynamic>),
        lastModifier = LastModifierDTO.fromJSON(json['lastModifier'] as Map<String, dynamic>);
}
