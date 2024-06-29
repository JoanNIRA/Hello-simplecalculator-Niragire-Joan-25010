import 'package:assigment1/CalculatorScreen.dart';
import 'package:assigment1/main.dart';
import 'package:assigment1/signInscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Calculator increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that we are on the initial screen (Sign In, Sign Up, or Calculator).
    expect(find.byType(SignInScreen), findsOneWidget); // Assuming SignInScreen is the initial screen

    // Tap the Calculator tab icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.calculate));
    await tester.pumpAndSettle();

    // Verify that we are now on the Calculator screen.
    expect(find.byType(CalculatorScreen), findsOneWidget);

    // Find the '0' text in Calculator screen.
    expect(find.text('0'), findsOneWidget);

    // Tap the '1' button and trigger a frame.
    await tester.tap(find.text('1'));
    await tester.pump();

    // Verify that our display shows 1.
    expect(find.text('0'), findsNothing); // '0' should not be found anymore
    expect(find.text('1'), findsOneWidget); // '1' should be found now
  });
}
