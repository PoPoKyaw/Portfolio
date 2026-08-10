import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:po_po_portfolio/main.dart';

void main() {
  testWidgets('Portfolio app renders brand title smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: PoPoPortfolioApp()));
    expect(find.text('PO PO KYAW'), findsWidgets);
  });
}
