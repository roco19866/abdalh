import 'package:flutter_test/flutter_test.dart';
import 'package:traof_app/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const TraofApp());
    expect(find.text('تراؤف'), findsOneWidget);
  });
}
