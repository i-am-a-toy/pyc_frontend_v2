import 'package:pyc/data/models/user/response/user_response.dart';

abstract class IUserRepository {
  Future<UserResponse> fetchMe();
}
