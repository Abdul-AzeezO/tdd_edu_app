import 'package:education_app/core/enums/update_user.dart';

import 'package:education_app/src/authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSource();
  Future<void> forgotPassword(String email);
  Future<AppUserModel> signIn({
    required String email,
    required String password,
  });
  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });
  Future<void> updateUser({required UpdateUserAction action, dynamic userData});
}
