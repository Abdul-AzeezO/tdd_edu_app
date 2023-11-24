import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:education_app/src/onboarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repository.mock.dart';

void main() {
  late OnboardingRepository repository;
  late CheckIfUserIsFirstTimer checkIfUserIsFirstTimer;

  setUp(() {
    repository = MockOnboardingRepository();
    checkIfUserIsFirstTimer = CheckIfUserIsFirstTimer(repository);
  });

  group(
    'Check If User is First Timer Tests',
    () {
      test(
        'Should call [repository.checkIfUserIsFirstTimer] and fail',
        () async {
          when(() => repository.checkIfUserIsFirstTimer()).thenAnswer(
            (_) async => Left(
              CacheFailure(
                message: 'could not get user token',
                statusCode: 500,
              ),
            ),
          );

          final result = await checkIfUserIsFirstTimer();

          expect(
            result,
            Left<Failure, void>(
              CacheFailure(
                message: 'could not get user token',
                statusCode: 500,
              ),
            ),
          );
          verify(() => repository.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(repository);
        },
      );

      test(
        'Should call [repository.checkIfUserIsFirstTimer] and return boolean',
        () async {
          when(() => repository.checkIfUserIsFirstTimer())
              .thenAnswer((_) async => const Right(true));

          final result = await checkIfUserIsFirstTimer();

          expect(result, const Right<void, bool>(true));
          verify(() => repository.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(repository);
        },
      );
    },
  );
}
