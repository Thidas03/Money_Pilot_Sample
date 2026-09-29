import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moneypilot_mobile/app.dart';
import 'package:moneypilot_mobile/features/navigation/presentation/main_navigation_shell.dart';
import 'package:moneypilot_mobile/features/transactions/presentation/transactions_screen.dart';
import 'package:moneypilot_mobile/shared/widgets/custom_button.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full navigation flow test across all screens', (WidgetTester tester) async {
    FlutterSecureStorage.setMockInitialValues({});

    await tester.pumpWidget(
      const ProviderScope(
        child: MoneyPilotApp(),
      ),
    );

    // 1. Splash Screen
    expect(find.text('MONEYPILOT'), findsOneWidget);

    // Advance splash delay to land on Onboarding
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();
    expect(find.text('Take Command of Every Rupee'), findsOneWidget);

    // Skip onboarding to land on Login
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome Back'), findsOneWidget);

    // 2. Navigate to Register
    final registerLink = find.text('Get Started');
    expect(registerLink, findsOneWidget);
    await tester.tap(registerLink);
    await tester.pumpAndSettle();
    expect(find.text('Start your journey with MoneyPilot today'), findsOneWidget);

    // 3. From Register, tap Create Account button to go to Dashboard
    final createAccountBtn = find.widgetWithText(CustomButton, 'Create Account');
    expect(createAccountBtn, findsOneWidget);
    await tester.ensureVisible(createAccountBtn);
    await tester.tap(createAccountBtn);
    await tester.pumpAndSettle();

    // 4. Dashboard Screen & Bottom Navigation Bar
    expect(find.text('Welcome aboard!'), findsOneWidget);
    expect(find.byType(MainNavigationShell), findsOneWidget);

    // 5. Navigate to Transactions Tab
    await tester.tap(find.text('Transactions').last);
    await tester.pumpAndSettle();
    expect(find.byType(TransactionsScreen), findsOneWidget);
    expect(find.text('Search transactions'), findsOneWidget);

    // 6. Navigate to Budgets Tab
    await tester.tap(find.text('Budget').last);
    await tester.pumpAndSettle();
    expect(find.text('Budgets'), findsWidgets);

    // 7. Navigate to Goals Tab
    await tester.tap(find.text('Goals').last);
    await tester.pumpAndSettle();
    expect(find.text('Track Your Financial Dreams'), findsOneWidget);

    // 8. Navigate to Reports Tab
    await tester.tap(find.text('Reports').last);
    await tester.pumpAndSettle();
    expect(find.text('Reports & Analytics'), findsOneWidget);

    // 9. Return to Home and open Profile
    await tester.tap(find.text('Home').last);
    await tester.pumpAndSettle();
    expect(find.text('Welcome aboard!'), findsOneWidget);

    // Open Profile via app bar icon
    await tester.tap(find.byIcon(Icons.person_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Pilot Profile'), findsOneWidget);
    expect(find.text('Encrypted JWT Storage'), findsOneWidget);

    // 10. Logout flow
    final logoutBtn = find.widgetWithText(CustomButton, 'Log Out');
    expect(logoutBtn, findsOneWidget);
    await tester.ensureVisible(logoutBtn);
    await tester.tap(logoutBtn);
    await tester.pumpAndSettle();

    // Verify redirected back to Login
    expect(find.text('Welcome Back'), findsOneWidget);
  });
}
