import 'package:dartz/dartz.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/update_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late UpdateUser usecase;
  const tParam = UpdateUserParams.empty();
  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = UpdateUser(repository);
    registerFallbackValue(tParam.action);
  });

  test(
    'should return void if successful',
    () async {
      when(
        () => repository.updateUser(
          userData: any<dynamic>(named: 'userData'),
          action: any(named: 'action'),
        ),
      ).thenAnswer((_) async => const Right(null));

      final result = await usecase(tParam);

      expect(result, const Right<void, void>(null));

      verify(
        () => repository.updateUser(
          userData: tParam.userData,
          action: tParam.action,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
