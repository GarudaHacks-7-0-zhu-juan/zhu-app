import 'package:flutter_test/flutter_test.dart';
import 'package:zhu_app/features/profile/domain/user_profile.dart';

void main() {
  test('parses the current user response', () {
    final profile = UserProfile.fromJson({
      'id': 'user-id',
      'displayName': 'Rani',
      'email': 'rani@example.com',
      'phoneNumber': '+628123456789',
      'createdAt': '2026-01-02T03:04:05.000Z',
      'updatedAt': '2026-02-03T04:05:06.000Z',
    });

    expect(profile.name, 'Rani');
    expect(profile.phoneNumber, '+628123456789');
  });
}
