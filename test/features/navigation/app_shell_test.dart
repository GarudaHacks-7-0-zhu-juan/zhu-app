import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';
import 'package:zhu_app/features/auth/controller/auth_session_controller.dart';
import 'package:zhu_app/features/auth/domain/auth_session_state.dart';
import 'package:zhu_app/features/auth/domain/auth_user.dart';
import 'package:zhu_app/features/navigation/presentation/app_shell.dart';
import 'package:zhu_app/features/profile/presentation/profile_page.dart';

void main() {
  testWidgets('bottom navigation shows contacts and profile pages', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authSessionControllerProvider.overrideWithValue(
            const AuthSessionState.authenticated(
              AuthUser(id: 'user-1', email: 'zhu@example.com'),
            ),
          ),
        ],
        child: ShadApp(theme: AppShadTheme.light, home: const AppShell()),
      ),
    );

    await tester.tap(find.byIcon(Icons.people_outline));
    await tester.pumpAndSettle();
    expect(find.text('No contacts yet'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();
    expect(find.text('zhu@example.com'), findsOneWidget);
  });

  testWidgets('profile disables sign out while request is pending', (
    tester,
  ) async {
    final signOut = Completer<void>();
    var signOutCalls = 0;

    await tester.pumpWidget(
      ShadApp(
        theme: AppShadTheme.light,
        home: ProfilePage(
          email: 'zhu@example.com',
          onSignOut: () {
            signOutCalls++;
            return signOut.future;
          },
        ),
      ),
    );

    await tester.tap(find.text('Sign out'));
    await tester.pump();
    expect(signOutCalls, 1);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    signOut.complete();
    await tester.pump();
    expect(find.text('Sign out'), findsOneWidget);
  });
}
