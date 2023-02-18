import 'package:pyc/data/models/dto/creator/creator_dto.dart';
import 'package:pyc/data/models/dto/last_modifier/last_modifier_dto.dart';

class NoticeCommentResponse {
  final int id;
  final String content;
  final CreatorDTO creator;
  final LastModifierDTO lastModifier;

  NoticeCommentResponse(
    this.id,
    this.content,
    this.creator,
    this.lastModifier,
  );

  NoticeCommentResponse.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        creator = CreatorDTO.fromJSON(json['creator'] as Map<String, dynamic>),
        lastModifier = LastModifierDTO.fromJSON(json['lastModifier'] as Map<String, dynamic>);
}
