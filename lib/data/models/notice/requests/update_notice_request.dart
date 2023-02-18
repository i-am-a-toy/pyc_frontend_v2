class UpdateNoticeRequest {
  final String _title;
  final String _content;

  UpdateNoticeRequest(this._title, this._content);

  Map<String, dynamic> toJSON() {
    return {"title": _title, "content": _content};
  }
}
