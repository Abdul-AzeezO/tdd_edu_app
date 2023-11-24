import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:education_app/src/onboarding/domain/usecases/cache_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repository.mock.dart';

void main() {
  late OnboardingRepository repository;
  late CacheFirstTimer cacheFirstTimer;

  setUp(() {
    repository = MockOnboardingRepository();
    cacheFirstTimer = CacheFirstTimer(repository);
  });

  group(
    'Cache First Timer Tests',
    () {
      test(
        'Shoud call the [repository.cacheFirstTimer] and fail',
        () async {
          when(() => repository.cacheFirstTimer()).thenAnswer(
            (_) async => Left(
              ServerFailure(message: 'unknown error occured', statusCode: 500),
            ),
          );
          final result = await cacheFirstTimer();
          expect(
            result,
            equals(
              Left<Failure, void>(
                ServerFailure(
                  message: 'unknown error occured',
                  statusCode: 500,
                ),
              ),
            ),
          );
          verify(() => repository.cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(repository);
        },
      );

      test(
        'Shoud call the [repository.cacheFirstTimer] and return success data',
        () async {
          when(() => repository.cacheFirstTimer())
              .thenAnswer((_) async => const Right(null));
          final result = await cacheFirstTimer();
          expect(result, equals(const Right<void, void>(null)));
          verify(() => repository.cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(repository);
        },
      );
    },
  );
}
