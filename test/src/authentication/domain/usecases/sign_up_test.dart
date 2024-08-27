import 'package:dartz/dartz.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late SignUp usecase;
  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = SignUp(repository);
  });

  const tParam = SignUpParams.empty();

  test(
    'should return void if successful',
    () async {
      when(
        () => repository.signUp(
          email: any(named: 'email'),
          password: any(named: 'password'),
          fullName: any(named: 'fullName'),
        ),
      ).thenAnswer((_) async => const Right(null));

      final result = await usecase(tParam);

      expect(result, const Right<void, void>(null));

      verify(
        () => repository.signUp(
          email: tParam.email,
          password: tParam.password,
          fullName: tParam.fullName,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
