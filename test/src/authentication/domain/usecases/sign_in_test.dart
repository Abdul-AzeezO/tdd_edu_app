import 'package:dartz/dartz.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late SignIn usecase;
  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = SignIn(repository);
  });

  const tParam = SignInParams.empty();
  const tUser = AppUser.empty();

  test(
    'should return [AppUser] data if successful',
    () async {
      when(
        () => repository.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Right(tUser));

      final result = await usecase(tParam);

      expect(result, const Right<void, AppUser>(tUser));

      verify(
        () => repository.signIn(
          email: tParam.email,
          password: tParam.password,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
