import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences preferences;
  late OnboardingLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    preferences = MockSharedPreferences();
    localDataSourceImpl = OnboardingLocalDataSourceImpl(preferences);
  });
  group(
    'OnboardingLocalDataSourceImpl Tests',
    () {
      test(
        'should be a subclass of [OnboardingLocalDataSource]',
        () => expect(localDataSourceImpl, isA<OnboardingLocalDataSource>()),
      );

      group('cacheFirstTimer Tests', () {
        test(
          '[localDataSourceImpl.cacheFirstTimer] should'
          ' call [preferences] to cache data',
          () async {
            when(() => preferences.setBool(any(), any()))
                .thenAnswer((_) async => true);
            await localDataSourceImpl.cacheFirstTimer();
            verify(() => preferences.setBool(kFirstTimerKey, false)).called(1);
            verifyNoMoreInteractions(preferences);
          },
        );

        test(
          '[localDataSourceImpl.cacheFirstTimer] should throw [CacheException]'
          ' when it fails',
          () async {
            when(() => preferences.setBool(any(), any()))
                .thenThrow(Exception());
            final methodCall = localDataSourceImpl.cacheFirstTimer;
            expect(methodCall, throwsA(isA<CacheException>()));
            verify(() => preferences.setBool(kFirstTimerKey, false)).called(1);
            verifyNoMoreInteractions(preferences);
          },
        );
      });

      group('checkIfUserIsFirstTimer', () {
        test(
          '[localDataSourceImpl.checkIfUserIsFirstTimer] should'
          ' call [preferences] and return false',
          () async {
            when(() => preferences.getBool(any())).thenReturn(false);
            final result = await localDataSourceImpl.checkIfUserIsFirstTimer();
            expect(result, false);
            verify(() => preferences.getBool(kFirstTimerKey)).called(1);
            verifyNoMoreInteractions(preferences);
          },
        );

        test(
          '[checkIfUserIsFirstTimer] should return true if [preferences]'
          ' return null',
          () async {
            when(() => preferences.getBool(any())).thenReturn(null);
            final result = await localDataSourceImpl.checkIfUserIsFirstTimer();
            expect(result, true);
            verify(() => preferences.getBool(kFirstTimerKey)).called(1);
            verifyNoMoreInteractions(preferences);
          },
        );

        test(
          '[checkIfUserIsFirstTimer] should throw [CacheException] if'
          ' [preferences] throws an [Exception]',
          () async {
            when(() => preferences.getBool(any())).thenThrow(Exception());
            final methodCall = localDataSourceImpl.checkIfUserIsFirstTimer;
            expect(methodCall, throwsA(isA<CacheException>()));
            verify(() => preferences.getBool(kFirstTimerKey)).called(1);
            verifyNoMoreInteractions(preferences);
          },
        );
      });
    },
  );
}
