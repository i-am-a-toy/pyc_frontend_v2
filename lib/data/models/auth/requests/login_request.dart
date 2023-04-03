class LoginRequest {
  final String _name;
  final String _password;

  LoginRequest(this._name, this._password);

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'password': _password,
    };
  }
}
