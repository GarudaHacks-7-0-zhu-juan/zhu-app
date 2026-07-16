import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';
import 'package:zhu_app/features/auth/controller/auth_session_controller.dart';
import 'package:zhu_app/features/auth/domain/auth_session_state.dart';
import 'package:zhu_app/features/auth/presentation/auth_page.dart';

void main() {
  testWidgets('registration requires an E.164 phone number', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authSessionControllerProvider.overrideWithValue(
            const AuthSessionState.unauthenticated(),
          ),
        ],
        child: ShadApp(
          theme: AppShadTheme.light,
          home: const AuthPage(mode: AuthMode.register),
        ),
      ),
    );

    final inputs = find.byType(EditableText);
    await tester.enterText(inputs.at(0), 'user@example.com');
    await tester.enterText(inputs.at(1), '08123456789');
    await tester.enterText(inputs.at(2), 'password123');
    await tester.enterText(inputs.at(3), 'password123');

    await tester.tap(find.text('Create account'));
    await tester.pump();

    expect(
      find.text('Enter a valid phone number with country code.'),
      findsOneWidget,
    );
  });
}
