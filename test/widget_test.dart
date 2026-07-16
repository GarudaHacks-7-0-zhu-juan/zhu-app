import 'package:flutter_test/flutter_test.dart';
import 'package:zhu_app/main.dart';

void main() {
  testWidgets('renders the app greeting', (tester) async {
    await tester.pumpWidget(const MainApp());

    expect(find.text('Hello World!'), findsOneWidget);
  });
}
