import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/main.dart';

void main() {
  testWidgets('renders the architectural schematic workspace', (tester) async {
    await tester.pumpWidget(const MainApp());

    expect(find.byType(ShadApp), findsOneWidget);
    expect(find.text('Schematic workspace'), findsOneWidget);
    expect(find.text('Current assembly'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Component states'),
      300,
      scrollable: find.byType(Scrollable),
    );
    expect(find.text('Component states'), findsOneWidget);
  });

  testWidgets('adds schematic marker', (tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MainApp());

    expect(find.text('2 markers placed'), findsOneWidget);
    await tester.tap(find.text('Add marker'));
    await tester.pump();

    expect(find.text('3 markers placed'), findsOneWidget);
  });
}
