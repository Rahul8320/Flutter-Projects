import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/auth/data/models/user_model.dart';
import 'package:tdd_tutorial/src/auth/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testModel = UserModel.empty();

  test("Should be a subclass of [User] entity", () {
    // Assert
    expect(testModel, isA<User>());
  });

  final testJson = fixture('user.json');
  final testMap = jsonDecode(testJson) as DataMap;

  group('fromMap', () {
    test('Should return a valid [UserModel] with data', () {
      // Act
      final result = UserModel.fromMap(testMap);

      // Assert
      expect(result, equals(testModel));
    });
  });

  group('fromJson', () {
    test('Should return a valid [UserModel] with data', () {
      // Act
      final result = UserModel.fromJson(testJson);

      // Assert
      expect(result, equals(testModel));
    });
  });

  group('toMap', () {
    test('Should return a valid [Map] with data', () {
      // Act
      final result = testModel.toMap();

      // Assert
      expect(result, equals(testMap));
    });
  });

  group('toJson', () {
    test('Should return a valid [Json String] with data', () {
      // Act
      final result = testModel.toJson();
      final testJson = jsonEncode({
        "id": "1",
        "name": "_empty.name",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt"
      });
      // Assert
      expect(result, equals(testJson));
    });
  });

  group('copyWith', () {
    test('Should return a valid [UserModel] with updated data', () {
      // Arrange
      const name = "Rahul";

      // Act
      final result = testModel.copyWith(name: name);

      // Assert
      expect(result.name, equals(name));
    });
  });
}
