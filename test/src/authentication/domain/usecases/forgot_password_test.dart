import 'package:dartz/dartz.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/forgot_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late ForgotPassword usecase;

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = ForgotPassword(repository);
  });

  test(
    'Should call [repository.forgotPassword]',
    () async {
      when(() => repository.forgotPassword(any()))
          .thenAnswer((_) async => const Right(null));

      final result = await usecase('');

      expect(result, const Right<void, void>(null));

      verify(() => repository.forgotPassword('')).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
