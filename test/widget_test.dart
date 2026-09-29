import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moneypilot_mobile/app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('New user sees Splash then routes to Onboarding walkthrough', (WidgetTester tester) async {
    FlutterSecureStorage.setMockInitialValues({});

    await tester.pumpWidget(
      const ProviderScope(
        child: MoneyPilotApp(),
      ),
    );

    // Initial frame renders splash screen
    expect(find.text('MONEYPILOT'), findsOneWidget);

    // Advance splash delay timer and route
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();

    // Verify navigation landed on Onboarding screen
    expect(find.text('MoneyPilot'), findsWidgets);
    expect(find.text('Take Command of Every Rupee'), findsOneWidget);
    expect(find.text('REAL-TIME TRACKING'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets('Returning user who completed onboarding routes directly to Login screen', (WidgetTester tester) async {
    FlutterSecureStorage.setMockInitialValues({
      'moneypilot_has_seen_onboarding': 'true',
    });

    await tester.pumpWidget(
      const ProviderScope(
        child: MoneyPilotApp(),
      ),
    );

    // Advance splash delay timer and route
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();

    // Verify navigation landed on Login screen
    expect(find.text('Welcome Back'), findsOneWidget);
  });

  testWidgets('Authenticated user routes directly to Dashboard', (WidgetTester tester) async {
    FlutterSecureStorage.setMockInitialValues({
      'moneypilot_jwt_token': 'dummy_jwt_token',
      'moneypilot_has_seen_onboarding': 'true',
    });

    await tester.pumpWidget(
      const ProviderScope(
        child: MoneyPilotApp(),
      ),
    );

    // Advance splash delay timer and route
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();

    // Verify navigation landed on Dashboard screen
    expect(find.text('Welcome aboard!'), findsOneWidget);
  });
}
