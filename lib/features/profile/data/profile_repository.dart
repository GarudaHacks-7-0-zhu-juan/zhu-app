import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zhu_app/features/auth/auth_providers.dart';
import 'package:zhu_app/features/auth/data/authenticated_api_client.dart';
import 'package:zhu_app/features/profile/domain/user_profile.dart';

part 'profile_repository.g.dart';

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(ref.watch(authenticatedApiClientProvider));
}

class ProfileRepository {
  const ProfileRepository(this._client);

  final AuthenticatedApiClient _client;

  Future<UserProfile> load() async {
    return UserProfile.fromJson(await _client.getJson('/users/me'));
  }
}
