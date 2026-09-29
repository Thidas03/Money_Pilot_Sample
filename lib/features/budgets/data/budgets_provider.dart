import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/budget_model.dart';

/// Seed initial category budgets.
final List<Budget> _initialBudgets = [
  Budget(
    id: 'budget-food',
    category: 'Food',
    amount: 15000,
    period: 'Monthly',
    note: 'Dining and takeout allowance',
    createdAt: DateTime(2026, 9, 1),
  ),
  Budget(
    id: 'budget-transport',
    category: 'Transport',
    amount: 10000,
    period: 'Monthly',
    note: 'Fuel, highway tolls and public transport',
    createdAt: DateTime(2026, 9, 1),
  ),
  Budget(
    id: 'budget-bills',
    category: 'Bills',
    amount: 8000,
    period: 'Monthly',
    note: 'Electricity, water and mobile internet',
    createdAt: DateTime(2026, 9, 1),
  ),
  Budget(
    id: 'budget-groceries',
    category: 'Groceries',
    amount: 12000,
    period: 'Monthly',
    note: 'Supermarket and household items',
    createdAt: DateTime(2026, 9, 1),
  ),
];

/// Notifier managing category-level budgets.
class BudgetsNotifier extends Notifier<List<Budget>> {
  @override
  List<Budget> build() {
    return _initialBudgets;
  }

  void addOrUpdateBudget(Budget newBudget) {
    final index = state.indexWhere(
      (b) => b.category.toLowerCase() == newBudget.category.toLowerCase(),
    );

    if (index >= 0) {
      final updated = List<Budget>.from(state);
      updated[index] = newBudget;
      state = updated;
    } else {
      state = [...state, newBudget];
    }
  }

  void removeBudget(String id) {
    state = state.where((b) => b.id != id).toList();
  }
}

/// Provider for list of category budgets.
final budgetsProvider = NotifierProvider<BudgetsNotifier, List<Budget>>(() {
  return BudgetsNotifier();
});

/// Notifier managing overall monthly target limit.
class MonthlyBudgetTargetNotifier extends Notifier<double> {
  @override
  double build() {
    return 50000.0;
  }

  void setTarget(double newTarget) {
    if (newTarget > 0) {
      state = newTarget;
    }
  }
}

/// Provider for overall monthly budget target limit.
final monthlyBudgetTargetProvider =
    NotifierProvider<MonthlyBudgetTargetNotifier, double>(() {
  return MonthlyBudgetTargetNotifier();
});
