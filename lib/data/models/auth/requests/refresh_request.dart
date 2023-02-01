class RefreshRequest {
  final String _accessToken;
  final String _refreshToken;

  RefreshRequest(
    this._accessToken,
    this._refreshToken,
  );

  Map<String, dynamic> toJSON() {
    return {
      'accessToken': _accessToken,
      'refreshToken': _refreshToken,
    };
  }
}
