import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/onboarding/domain/usecases/cache_first_timer.dart';
import 'package:education_app/src/onboarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:education_app/src/onboarding/view/cubit/onboarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfUserIsFirstTimer extends Mock
    implements CheckIfUserIsFirstTimer {}

void main() {
  late CacheFirstTimer cacheFirstTimer;
  late CheckIfUserIsFirstTimer checkIfUserIsFirstTimer;
  late OnboardingCubit cubit;
  final kCacheFailure = CacheFailure(message: 'message', statusCode: 500);

  setUp(() {
    cacheFirstTimer = MockCacheFirstTimer();
    checkIfUserIsFirstTimer = MockCheckIfUserIsFirstTimer();
    cubit = OnboardingCubit(
      cacheFirstTimer: cacheFirstTimer,
      checkIfUserIsFirstTimer: checkIfUserIsFirstTimer,
    );
  });

  tearDown(() => cubit.close());

  group(
    'Onboarding Cubit Tests',
    () {
      test(
        'state should be [OnboardingInitial]',
        () => expect(cubit.state, OnboardingInitial()),
      );
      group('cacheFirstTimer Tests', () {
        blocTest<OnboardingCubit, OnboardingState>(
          'emits [CachingFirstTimer,UserCached] when successful',
          build: () {
            when(() => cacheFirstTimer())
                .thenAnswer((_) async => const Right(null));
            return cubit;
          },
          act: (bloc) => cubit.cacheFirstTimer(),
          expect: () => const [CachingFirstTimer(), UserCached()],
          verify: (_) {
            verify(() => cacheFirstTimer()).called(1);
            verifyNoMoreInteractions(cacheFirstTimer);
          },
        );

        blocTest<OnboardingCubit, OnboardingState>(
          'emits [CachingFirstTimer,OnboardingError] when failure',
          build: () {
            when(() => cacheFirstTimer()).thenAnswer(
              (_) async => Left(kCacheFailure),
            );
            return cubit;
          },
          act: (bloc) => cubit.cacheFirstTimer(),
          expect: () => [
            const CachingFirstTimer(),
            OnboardingError(message: kCacheFailure.errorMessage),
          ],
          verify: (_) {
            verify(() => cacheFirstTimer()).called(1);
            verifyNoMoreInteractions(cacheFirstTimer);
          },
        );
      });

      group('checkIfUserIsFirstTimer Tests', () {
        blocTest<OnboardingCubit, OnboardingState>(
          'emits [CheckingIfUserIsFirstTimer,OnboardingStatus] when successful',
          build: () {
            when(() => checkIfUserIsFirstTimer())
                .thenAnswer((_) async => const Right(true));
            return cubit;
          },
          act: (bloc) => cubit.checkIfuserIsFirstTimer(),
          expect: () => const [
            CheckingIfUserIsFirstTimer(),
            OnboardingStatus(isFirstTimer: true),
          ],
          verify: (_) {
            verify(() => checkIfUserIsFirstTimer()).called(1);
            verifyNoMoreInteractions(checkIfUserIsFirstTimer);
          },
        );

        blocTest<OnboardingCubit, OnboardingState>(
          'emits [CheckingIfUserIsFirstTimer,OnboardingStatus] when failure',
          build: () {
            when(() => checkIfUserIsFirstTimer()).thenAnswer(
              (_) async => Left(kCacheFailure),
            );
            return cubit;
          },
          act: (bloc) => cubit.checkIfuserIsFirstTimer(),
          expect: () => const [
            CheckingIfUserIsFirstTimer(),
            OnboardingStatus(isFirstTimer: true),
          ],
          verify: (_) {
            verify(() => checkIfUserIsFirstTimer()).called(1);
            verifyNoMoreInteractions(checkIfUserIsFirstTimer);
          },
        );
      });
    },
  );
}
