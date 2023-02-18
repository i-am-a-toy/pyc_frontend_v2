class CreateNoticeCommentRequest {
  final String _comment;

  CreateNoticeCommentRequest(this._comment);

  Map<String, dynamic> toJSON() {
    return {"comment": _comment};
  }
}
