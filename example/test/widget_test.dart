import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';
import 'package:flutter_body_part_selector/flutter_body_part_selector.dart';

void main() {
  testWidgets('Body Selector Example smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the BodyPartSelector is present.
    expect(find.byType(InteractiveBodySvg), findsOneWidget);
    
    // Verify that flip and clear icons are present in the AppBar.
    expect(find.byIcon(Icons.flip), findsOneWidget);
    expect(find.byIcon(Icons.clear), findsOneWidget);

    // Verify zoom buttons are present.
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.remove), findsOneWidget);
  });
}
