import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';
import 'package:zhu_app/features/profile/controller/my_profile_controller.dart';
import 'package:zhu_app/features/profile/domain/user_profile.dart';
import 'package:zhu_app/features/profile/presentation/profile_page.dart';
import 'package:zhu_app/features/safety/controller/protect_me_controller.dart';
import 'package:zhu_app/features/safety/domain/protect_me_status.dart';

void main() {
  UserProfile profile({String? displayName}) => UserProfile(
    id: 'user-id',
    displayName: displayName,
    email: 'person@example.com',
    phoneNumber: '+628123456789',
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
  );

  Widget buildProfile(
    Future<UserProfile> Function() load, {
    Future<List<ProtectMeStatus>> Function()? loadProtectMeStatuses,
  }) {
    return ProviderScope(
      overrides: [
        myProfileProvider.overrideWith((_) => load()),
        protectMeControllerProvider.overrideWith(
          () => _FakeProtectMeController(
            loadProtectMeStatuses ?? _defaultProtectMeStatuses,
          ),
        ),
      ],
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
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('pull-to-refresh reloads profile and Protect Me statuses', (
    tester,
  ) async {
    var profileRequests = 0;
    var protectionRequests = 0;
    await tester.pumpWidget(
      buildProfile(
        () async {
          profileRequests += 1;
          return profile(displayName: 'Rani $profileRequests');
        },
        loadProtectMeStatuses: () async {
          protectionRequests += 1;
          return _defaultProtectMeStatuses();
        },
      ),
    );
    await tester.pumpAndSettle();

    final refresh = tester
        .state<RefreshIndicatorState>(find.byType(RefreshIndicator))
        .show();
    await tester.pumpAndSettle();
    await refresh;

    expect(profileRequests, 2);
    expect(protectionRequests, 2);
    expect(find.text('Rani 2'), findsOneWidget);
  });
}

Future<List<ProtectMeStatus>> _defaultProtectMeStatuses() async {
  return const [
    ProtectMeStatus(
      riskType: ProtectMeRiskType.highRiskArea,
      riskLevel: 'NONE',
      activationMode: ProtectMeActivationMode.off,
    ),
    ProtectMeStatus(
      riskType: ProtectMeRiskType.disaster,
      riskLevel: 'NONE',
      activationMode: ProtectMeActivationMode.off,
    ),
  ];
}

class _FakeProtectMeController extends ProtectMeController {
  _FakeProtectMeController(this._loadStatuses);

  final Future<List<ProtectMeStatus>> Function() _loadStatuses;

  @override
  Future<List<ProtectMeStatus>> build() => _loadStatuses();
}
