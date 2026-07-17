import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zhu_app/features/profile/data/profile_repository.dart';
import 'package:zhu_app/features/profile/domain/user_profile.dart';

part 'my_profile_controller.g.dart';

@riverpod
Future<UserProfile> myProfile(Ref ref) {
  return ref.read(profileRepositoryProvider).load();
}
