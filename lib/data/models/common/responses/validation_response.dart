class ValidationResponse {
  final bool _isValid;

  ValidationResponse(this._isValid);
  ValidationResponse.fromJSON(Map<String, dynamic> json) : _isValid = json['isValid'];

  bool get isValid => _isValid;
}
