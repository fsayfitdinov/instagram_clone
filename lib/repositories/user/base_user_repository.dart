import 'package:instagram/models/models.dart';

abstract class BaseUserRepository {
  Future<UserModel> getUserWithId({required String userId});
  Future<void> updateUser({required UserModel user});
}
