import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';
import 'package:zhu_app/features/home/presentation/home_page.dart';
import 'package:zhu_app/features/relationships/controller/relationships_controller.dart';
import 'package:zhu_app/features/relationships/domain/relationship_kind.dart';
import 'package:zhu_app/features/relationships/domain/relationship_models.dart';
import 'package:zhu_app/features/safety/controller/protect_me_controller.dart';
import 'package:zhu_app/features/safety/domain/protect_me_status.dart';

void main() {
  testWidgets('shows safety shortcuts without a manage guardians action', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: '/workspace',
      routes: [
        GoRoute(path: '/workspace', builder: (_, _) => const HomePage()),
        GoRoute(
          path: '/guardian-notifications',
          builder: (_, _) => const Scaffold(body: Text('Guardian alerts page')),
        ),
        GoRoute(
          path: '/profile',
          builder: (_, _) =>
              const Scaffold(body: Text('Protect Me profile page')),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          protectMeControllerProvider.overrideWith(
            _FakeProtectMeController.new,
          ),
          relationshipsControllerProvider(
            RelationshipKind.guardians,
          ).overrideWith(_FakeRelationshipsController.new),
        ],
        child: ShadApp.router(theme: AppShadTheme.light, routerConfig: router),
      ),
    );

    expect(find.text('Manage guardians'), findsNothing);
    expect(find.text('Guardian alerts'), findsOneWidget);
    expect(find.text('Protect Me settings'), findsOneWidget);

    await tester.tap(find.text('Guardian alerts'));
    await tester.pumpAndSettle();
    expect(find.text('Guardian alerts page'), findsOneWidget);

    router.go('/workspace');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Protect Me settings'));
    await tester.pumpAndSettle();
    expect(find.text('Protect Me profile page'), findsOneWidget);
  });
}

class _FakeProtectMeController extends ProtectMeController {
  @override
  Future<List<ProtectMeStatus>> build() async {
    return const [
      ProtectMeStatus(
        riskType: ProtectMeRiskType.highRiskArea,
        riskLevel: 'LOW',
        activationMode: ProtectMeActivationMode.auto,
      ),
    ];
  }
}

class _FakeRelationshipsController extends RelationshipsController {
  @override
  Future<RelationshipData> build(RelationshipKind kind) async {
    return const RelationshipData(accepted: [], requests: []);
  }
}
