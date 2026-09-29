import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/transaction_model.dart';

/// Initial transactions matching the design mockup.
final List<Transaction> _initialTransactions = [
  Transaction(
    id: 'tx-1',
    title: 'Fuel',
    category: 'Transport',
    amount: 2500,
    type: TransactionType.expense,
    date: DateTime(2026, 9, 10),
    note: 'Weekly petrol refill',
  ),
  Transaction(
    id: 'tx-2',
    title: 'PickMe earnings',
    category: 'Work',
    amount: 7800,
    type: TransactionType.income,
    date: DateTime(2026, 9, 9),
    note: 'Weekend driver earnings payout',
  ),
  Transaction(
    id: 'tx-3',
    title: 'Groceries',
    category: 'Food',
    amount: 4200,
    type: TransactionType.expense,
    date: DateTime(2026, 9, 8),
    note: 'Supermarket vegetables & essentials',
  ),
  Transaction(
    id: 'tx-4',
    title: 'Phone bill',
    category: 'Bills',
    amount: 1850,
    type: TransactionType.expense,
    date: DateTime(2026, 9, 7),
    note: 'Dialog postpaid mobile connection',
  ),
];

/// Notifier managing transactions state.
class TransactionsNotifier extends Notifier<List<Transaction>> {
  @override
  List<Transaction> build() {
    return _initialTransactions;
  }

  void addTransaction(Transaction tx) {
    state = [tx, ...state];
  }

  void deleteTransaction(String id) {
    state = state.where((t) => t.id != id).toList();
  }
}

/// Provider for transactions list.
final transactionsProvider =
    NotifierProvider<TransactionsNotifier, List<Transaction>>(() {
  return TransactionsNotifier();
});

/// Filter state notifier: null for All, or TransactionType.expense / income.
class TransactionFilterNotifier extends Notifier<TransactionType?> {
  @override
  TransactionType? build() => TransactionType.expense;

  void setFilter(TransactionType? filter) {
    state = filter;
  }
}

final transactionFilterProvider =
    NotifierProvider<TransactionFilterNotifier, TransactionType?>(() {
  return TransactionFilterNotifier();
});

/// Search query notifier for transactions list.
class TransactionSearchNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setSearch(String query) {
    state = query;
  }
}

final transactionSearchProvider =
    NotifierProvider<TransactionSearchNotifier, String>(() {
  return TransactionSearchNotifier();
});

/// Filtered transactions based on active tab and search query.
final filteredTransactionsProvider = Provider<List<Transaction>>((ref) {
  final transactions = ref.watch(transactionsProvider);
  final filter = ref.watch(transactionFilterProvider);
  final search = ref.watch(transactionSearchProvider).trim().toLowerCase();

  return transactions.where((tx) {
    // Filter by type (Expense / Income)
    if (filter != null && tx.type != filter) {
      return false;
    }

    // Filter by search query
    if (search.isNotEmpty) {
      final matchesTitle = tx.title.toLowerCase().contains(search);
      final matchesCategory = tx.category.toLowerCase().contains(search);
      final matchesNote = (tx.note ?? '').toLowerCase().contains(search);
      if (!matchesTitle && !matchesCategory && !matchesNote) {
        return false;
      }
    }

    return true;
  }).toList();
});

/// Total Income computed from transactions
final totalIncomeProvider = Provider<double>((ref) {
  final transactions = ref.watch(transactionsProvider);
  return transactions
      .where((t) => t.type == TransactionType.income)
      .fold<double>(0, (sum, item) => sum + item.amount);
});

/// Total Expense computed from transactions
final totalExpenseProvider = Provider<double>((ref) {
  final transactions = ref.watch(transactionsProvider);
  return transactions
      .where((t) => t.type == TransactionType.expense)
      .fold<double>(0, (sum, item) => sum + item.amount);
});

/// Net Savings computed from transactions
final netSavingsProvider = Provider<double>((ref) {
  final income = ref.watch(totalIncomeProvider);
  final expense = ref.watch(totalExpenseProvider);
  return income - expense;
});

/// Savings Rate percentage (0 to 100)
final savingsRateProvider = Provider<double>((ref) {
  final income = ref.watch(totalIncomeProvider);
  final savings = ref.watch(netSavingsProvider);
  if (income <= 0) return 0.0;
  final rate = (savings / income) * 100;
  return rate < 0 ? 0.0 : (rate > 100 ? 100.0 : rate);
});

/// Top most recent transactions for dashboard preview
final recentTransactionsProvider = Provider<List<Transaction>>((ref) {
  final transactions = ref.watch(transactionsProvider);
  return transactions.take(4).toList();
});

