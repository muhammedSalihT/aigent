import 'package:flutter_test/flutter_test.dart';
import 'package:aigent_softwares/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AIgent softwaresApp());
  });
}
