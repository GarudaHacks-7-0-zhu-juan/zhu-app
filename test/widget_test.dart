import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/main.dart';

void main() {
  testWidgets('renders the app greeting', (tester) async {
    await tester.pumpWidget(const MainApp());

    expect(find.byType(ShadApp), findsOneWidget);
    expect(find.text('Hello World!'), findsOneWidget);
  });
}
