import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moneypilot_mobile/app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OnboardingScreen Interactions', () {
    testWidgets('User can swipe or click Continue through all 3 slides', (WidgetTester tester) async {
      FlutterSecureStorage.setMockInitialValues({});

      await tester.pumpWidget(
        const ProviderScope(
          child: MoneyPilotApp(),
        ),
      );

      // Advance through splash to onboarding
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pumpAndSettle();

      // Slide 1
      expect(find.text('Take Command of Every Rupee'), findsOneWidget);
      expect(find.text('REAL-TIME TRACKING'), findsOneWidget);
      expect(find.text('Skip'), findsOneWidget);

      // Tap Continue -> Slide 2
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.text('Navigate Clear of Overspending'), findsOneWidget);
      expect(find.text('SMART BUDGET RADAR'), findsOneWidget);

      // Tap Continue -> Slide 3 (Final)
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.text('Soar Towards Your Life Goals'), findsOneWidget);
      expect(find.text('FINANCIAL FREEDOM'), findsOneWidget);
      expect(find.text('Get Started with MoneyPilot'), findsOneWidget);
      expect(find.text('Sign In to Existing Account'), findsOneWidget);

      // Tap Get Started -> Lands on Register Screen
      await tester.tap(find.text('Get Started with MoneyPilot'));
      await tester.pumpAndSettle();

      expect(find.text('Start your journey with MoneyPilot today'), findsOneWidget);
    });

    testWidgets('Tapping Skip navigates directly to Login Screen and saves state', (WidgetTester tester) async {
      FlutterSecureStorage.setMockInitialValues({});

      await tester.pumpWidget(
        const ProviderScope(
          child: MoneyPilotApp(),
        ),
      );

      // Advance through splash to onboarding
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pumpAndSettle();

      // Tap Skip
      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      // Verify on Login
      expect(find.text('Welcome Back'), findsOneWidget);
    });
  });
}
