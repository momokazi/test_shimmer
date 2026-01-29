import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reusable_shimmer/reusable_shimmer.dart';

void main() {
  testWidgets('Skeleton widget render test', (WidgetTester tester) async {
    // Build a simple Skeleton
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Skeleton(width: 100, height: 100)),
      ),
    );

    // Verify it exists in the tree
    expect(find.byType(Skeleton), findsOneWidget);

    // You could also verify it has the right size if you looked at the RenderObject,
    // but simplified presence check is enough for package validation.
  });
}
