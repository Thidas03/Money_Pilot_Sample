import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moneypilot_mobile/app.dart';
import 'package:moneypilot_mobile/features/budgets/presentation/add_budget_screen.dart';
import 'package:moneypilot_mobile/features/budgets/presentation/budgets_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Budget screen has Add Budget button (not Add Transaction) and opens Add Budget screen', (WidgetTester tester) async {
    FlutterSecureStorage.setMockInitialValues({
      'moneypilot_jwt_token': 'dummy_jwt_token',
      'moneypilot_has_seen_onboarding': 'true',
    });

    await tester.pumpWidget(
      const ProviderScope(
        child: MoneyPilotApp(),
      ),
    );

    // Advance splash delay
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();

    // Navigate to Budget tab in bottom navigation
    final budgetTab = find.text('Budget').last;
    expect(budgetTab, findsOneWidget);
    await tester.tap(budgetTab);
    await tester.pumpAndSettle();

    // Verify Budgets screen is active
    expect(find.byType(BudgetsScreen), findsOneWidget);

    // Verify the FAB is labeled "Add Budget", and NOT "Add Transaction"
    expect(find.text('Add Budget'), findsWidgets);
    expect(find.text('Add Transaction'), findsNothing);

    // Tap the Add Budget button in the AppBar actions
    final addBudgetBtn = find.widgetWithText(FilledButton, 'Add Budget');
    expect(addBudgetBtn, findsOneWidget);
    await tester.tap(addBudgetBtn);
    await tester.pumpAndSettle();

    // Verify navigation landed on AddBudgetScreen (NOT AddTransactionScreen)
    expect(find.byType(AddBudgetScreen), findsOneWidget);
    expect(find.text('Add budget'), findsOneWidget);
    expect(find.text('Category Budget'), findsOneWidget);
    expect(find.text('Monthly Target'), findsOneWidget);
    expect(find.text('Save budget'), findsOneWidget);

    // Tap back button
    final backBtn = find.byKey(const Key('add_budget_back_button'));
    expect(backBtn, findsOneWidget);
    await tester.tap(backBtn);
    await tester.pumpAndSettle();

    // Verify returned to Budgets screen
    expect(find.byType(BudgetsScreen), findsOneWidget);
  });
}
