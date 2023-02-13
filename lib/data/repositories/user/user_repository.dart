import 'package:get/get.dart';
import 'package:pyc/data/models/user/response/user_response.dart';
import 'package:pyc/data/providers/user/user_provider_interface.dart';
import 'package:pyc/data/repositories/user/user_repository_interface.dart';

class UserRepository extends GetxService implements IUserRepository {
  final IUserProvider provider;
  UserRepository(this.provider);

  @override
  Future<UserResponse> fetchMe() async {
    final response = await provider.fetchMe();
    return UserResponse.fromJSON(response.data);
  }
}
