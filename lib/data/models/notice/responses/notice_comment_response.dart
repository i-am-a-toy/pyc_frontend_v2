import 'package:pyc/data/models/dto/creator/creator_dto.dart';
import 'package:pyc/data/models/dto/last_modifier/last_modifier_dto.dart';

class NoticeCommentResponse {
  final int id;
  final String content;
  final CreatorDTO creator;
  final DateTime createdAt;
  final LastModifierDTO lastModifier;
  final DateTime lastModifiedAt;

  NoticeCommentResponse(
    this.id,
    this.content,
    this.creator,
    this.createdAt,
    this.lastModifier,
    this.lastModifiedAt,
  );

  NoticeCommentResponse.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        creator = CreatorDTO.fromJSON(json['creator'] as Map<String, dynamic>),
        createdAt = DateTime.parse(json['createdAt']),
        lastModifier = LastModifierDTO.fromJSON(json['lastModifier'] as Map<String, dynamic>),
        lastModifiedAt = DateTime.parse(json['lastModifiedAt']);
}
