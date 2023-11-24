import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/utils/typedefs.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFuture<AppUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultFuture<void> forgotPassword(String email);
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });
}
