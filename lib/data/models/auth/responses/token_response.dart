class TokenResponse {
  final String _accessToken;
  final String _refreshToken;

  TokenResponse(
    this._accessToken,
    this._refreshToken,
  );

  TokenResponse.fromJSON(Map<String, dynamic> json)
      : _accessToken = json['accessToken'],
        _refreshToken = json['refreshToken'];

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
}
