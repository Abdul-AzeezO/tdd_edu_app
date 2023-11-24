import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:education_app/src/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:education_app/src/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingLocalDataSource extends Mock
    implements OnboardingLocalDataSource {}

void main() {
  late OnboardingLocalDataSource dataSource;
  late OnboardingRepositoryImpl repositoryImpl;

  setUp(() {
    dataSource = MockOnboardingLocalDataSource();
    repositoryImpl = OnboardingRepositoryImpl(dataSource);
  });

  group(
    'OnboardingRepositoryImpl Tests',
    () {
      test(
        'should be a subclass of [OnboardingRepository]',
        () => expect(repositoryImpl, isA<OnboardingRepository>()),
      );

      test(
        '[repositoryImpl.cacheFirstTimer] should complete successfully',
        () async {
          when(() => dataSource.cacheFirstTimer())
              .thenAnswer((_) async => Future.value());

          final result = await repositoryImpl.cacheFirstTimer();

          expect(result, equals(const Right<void, void>(null)));

          verify(() => dataSource.cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );

      test(
        '[repositoryImpl.cacheFirstTimer] should return'
        ' [CacheFailure] when called',
        () async {
          when(() => dataSource.cacheFirstTimer())
              .thenThrow(const CacheException(message: 'invalid token'));

          final result = await repositoryImpl.cacheFirstTimer();

          expect(
            result,
            equals(
              Left<CacheFailure, void>(
                CacheFailure(message: 'invalid token', statusCode: 500),
              ),
            ),
          );

          verify(() => dataSource.cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );

      test(
        '[repositoryImpl.checkIfUserIsFirstTimer] should complete successfully',
        () async {
          when(() => dataSource.checkIfUserIsFirstTimer())
              .thenAnswer((_) async => false);

          final result = await repositoryImpl.checkIfUserIsFirstTimer();

          expect(result, equals(const Right<void, bool>(false)));

          verify(() => dataSource.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );

      test(
        '[repositoryImpl.checkIfUserIsFirstTimer] should return'
        ' [CacheFailure] when called',
        () async {
          when(() => dataSource.checkIfUserIsFirstTimer())
              .thenThrow(const CacheException(message: 'invalid token'));

          final result = await repositoryImpl.checkIfUserIsFirstTimer();

          expect(
            result,
            equals(
              Left<CacheFailure, void>(
                CacheFailure(message: 'invalid token', statusCode: 500),
              ),
            ),
          );

          verify(() => dataSource.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );
    },
  );
}
