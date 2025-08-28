// test/widget_test.dart
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_flutter/main.dart';

void main() {
  testWidgets('Row + Flexible example test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app bar title is correct
    expect(find.text('Row + Flexible 示例'), findsOneWidget);

    // Verify that the Row widget exists
    expect(find.byType(Row), findsOneWidget);

    // Verify that there are two Flexible widgets
    expect(find.byType(Flexible), findsNWidgets(2));

    // Verify that there are two Container widgets
    expect(find.byType(Container), findsNWidgets(2));
  });
}
