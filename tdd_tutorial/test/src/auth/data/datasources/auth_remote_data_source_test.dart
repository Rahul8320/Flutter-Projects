import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/utils/constants.dart';
import 'package:tdd_tutorial/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tdd_tutorial/src/auth/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthRemoteDataSource dataSource;

  setUp(() {
    client = MockClient();
    dataSource = AuthRemoteDataSourceImplement(client);
    registerFallbackValue(Uri());
  });

  const message = "Bad Request";
  const statusCode = 400;

  group('createUser', () {
    const createdAt = "created at 2023";
    const name = "Far From Home Coming";
    const avatar = "SpiderMan";

    test('should complete successfully when the status code is 201', () async {
      // Arrange
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201));

      // Act
      final methodCall = dataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // Assert
      expect(methodCall, completes);
      verify(() => client.post(Uri.parse('$apiBaseUrl/users'),
              body: jsonEncode(
                  {'createdAt': createdAt, 'name': name, 'avatar': avatar})))
          .called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [ApiException] when the status code is not 201',
        () async {
      // Arrange
      when(() => client.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response(message, statusCode));

      // Act
      final methodCall = dataSource.createUser;

      // Assert
      expect(
          () async =>
              methodCall(createdAt: createdAt, name: name, avatar: avatar),
          throwsA(
              const ApiException(message: message, statusCode: statusCode)));
      verify(() => client.post(Uri.parse('$apiBaseUrl/users'),
              body: jsonEncode(
                  {'createdAt': createdAt, 'name': name, 'avatar': avatar})))
          .called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('getUsers', () {
    const testUserList = [UserModel.empty()];

    test('should return [List<UserModel>] when the status code is 200',
        () async {
      // Arrange
      when(() => client.get(any())).thenAnswer((_) async =>
          http.Response(jsonEncode([testUserList.first.toMap()]), 200));

      // Act
      final result = await dataSource.getUsers();

      // Assert
      expect(result, equals(testUserList));
      verify(() => client.get(Uri.parse("$apiBaseUrl/users"))).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [ApiException] when the status code is not 200',
        () async {
      // Arrange
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response(message, statusCode));

      // Act
      final methodCall = dataSource.getUsers();

      // Assert
      expect(
          methodCall,
          throwsA(
              const ApiException(message: message, statusCode: statusCode)));
      verify(() => client.get(
            Uri.parse('$apiBaseUrl/users'),
          )).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
