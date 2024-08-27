import 'dart:convert';

import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tAppUserModel = AppUserModel.empty();
  final tJson = fixture('user.json');
  final tDataMap = jsonDecode(tJson) as DataMap;
  group('AppUserModel Tests', () {
    test(
      'should be a type of AppUser',
      () => expect(tAppUserModel, isA<AppUser>()),
    );

    test('fromMap should return a [AppUserModel] equal to defined model', () {
      final result = AppUserModel.fromMap(tDataMap);
      expect(result, equals(tAppUserModel));
    });

    test('toMap should return a [DataMap] with the right data', () {
      final result = tAppUserModel.toMap();
      expect(result, equals(tDataMap));
    });

    test('copyWith return a [AppUserModel] with different data', () {
      final newUser = tAppUserModel.copyWith(uid: '10');
      expect(newUser.uid, equals('10'));
      expect(newUser, isNot(tAppUserModel));
    });

    test('should throw an Error if map is invalid', () {
      final map = tDataMap..remove('uid');
      const call = AppUserModel.fromMap;
      expect(() => call(map), throwsA(isA<Error>()));
    });
  });
}
