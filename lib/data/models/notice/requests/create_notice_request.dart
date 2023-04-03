class CreateNoticeRequest {
  final String _title;
  final String _content;

  CreateNoticeRequest(this._title, this._content);

  Map<String, dynamic> toJSON() {
    return {"title": _title, "content": _content};
  }
}
