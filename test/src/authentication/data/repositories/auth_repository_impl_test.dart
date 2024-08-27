import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:education_app/src/authentication/data/repositories/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource dataSource;

  late AuthenticationRepositoryImpl repositoryImpl;

  setUp(() {
    dataSource = MockAuthRemoteDataSource();
    repositoryImpl = AuthenticationRepositoryImpl(dataSource);
  });

  group(
    'AuthenticationRepositoryImpl Tests',
    () {
      group(
        'signIn Tests',
        () {
          test(
            'should return [AppUser] if successful',
            () async {
              when(
                () => dataSource.signIn(
                  email: any(named: 'email'),
                  password: any(named: 'password'),
                ),
              ).thenAnswer((_) async => const AppUserModel.empty());

              final result = await repositoryImpl.signIn(
                email: '',
                password: '',
              );

              expect(
                result,
                equals(const Right<void, AppUserModel>(AppUserModel.empty())),
              );
              verify(() => dataSource.signIn(email: '', password: ''))
                  .called(1);
              verifyNoMoreInteractions(dataSource);
            },
          );

          test(
            'should return [ServerFailure] if request fails',
            () async {
              when(
                () => dataSource.signIn(
                    email: any(named: 'email'),
                    password: any(named: 'password')),
              ).thenThrow(
                const ServerException(
                  message: 'unable to sign in',
                  statusCode: 500,
                ),
              );

              final result =
                  await repositoryImpl.signIn(email: '', password: '');

              expect(
                result,
                equals(
                  Left<Failure, void>(
                    ServerFailure(
                      message: 'unable to sign in',
                      statusCode: 500,
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}
