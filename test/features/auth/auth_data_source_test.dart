import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhu_app/features/auth/data/auth_data_source.dart';

void main() {
  test('register sends the optional display name', () async {
    late RequestOptions request;
    final dio = Dio()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            request = options;
            handler.resolve(
              Response<dynamic>(
                requestOptions: options,
                statusCode: 201,
                data: {
                  'accessToken': 'access-token',
                  'refreshToken': 'refresh-token',
                },
              ),
            );
          },
        ),
      );

    await AuthDataSource(dio).register(
      email: 'user@example.com',
      password: 'password123',
      phoneNumber: '+628123456789',
      displayName: 'Ada Lovelace',
    );

    expect(request.path, '/auth/register');
    expect(request.data, {
      'email': 'user@example.com',
      'password': 'password123',
      'phoneNumber': '+628123456789',
      'displayName': 'Ada Lovelace',
    });
  });
}
