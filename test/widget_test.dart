import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salon_flutter/feature/navigation/app_root_router.dart';

void main() {
  testWidgets('App starts without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const AppRootRouter(),
        // можно добавить другие зависимости, если нужно
      ),
    );
    expect(find.byType(AppRootRouter), findsOneWidget);
  });
}
