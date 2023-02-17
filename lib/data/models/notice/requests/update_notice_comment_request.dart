class UpdateNoticeCommentRequest {
  final String _comment;

  UpdateNoticeCommentRequest(this._comment);

  Map<String, dynamic> toJSON() {
    return {"comment": _comment};
  }
}
