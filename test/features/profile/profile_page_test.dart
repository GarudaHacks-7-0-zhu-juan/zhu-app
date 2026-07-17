import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';
import 'package:zhu_app/features/profile/controller/my_profile_controller.dart';
import 'package:zhu_app/features/profile/domain/user_profile.dart';
import 'package:zhu_app/features/profile/presentation/profile_page.dart';

void main() {
  UserProfile profile({String? displayName}) => UserProfile(
    id: 'user-id',
    displayName: displayName,
    email: 'person@example.com',
    phoneNumber: '+628123456789',
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
  );

  Widget buildProfile(Future<UserProfile> Function() load) {
    return ProviderScope(
      overrides: [myProfileProvider.overrideWith((_) => load())],
      child: ShadApp(
        theme: AppShadTheme.light,
        home: ProfilePage(onSignOut: () async {}),
      ),
    );
  }

  testWidgets('renders profile contact details without private account data', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildProfile(() async => profile(displayName: 'Rani')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Rani'), findsOneWidget);
    expect(find.text('person@example.com'), findsOneWidget);
    expect(find.text('+628123456789'), findsOneWidget);
    expect(find.text('user-id'), findsNothing);
    expect(find.text('2026'), findsNothing);
  });

  testWidgets('uses email when display name is null or blank', (tester) async {
    await tester.pumpWidget(
      buildProfile(() async => profile(displayName: '  ')),
    );
    await tester.pumpAndSettle();

    expect(find.text('person@example.com'), findsNWidgets(2));
  });

  testWidgets('shows retry state when profile API loading fails', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildProfile(() async => throw Exception('network unavailable')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Profile unavailable'), findsOneWidget);
    expect(find.text('Retry'), findsNWidgets(2));
  });
}
