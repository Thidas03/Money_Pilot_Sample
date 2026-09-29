import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moneypilot_mobile/core/constants/categories.dart';

void main() {
  group('AppCategories Tests', () {
    test('contains all 12 MoneyPilot web categories', () {
      expect(AppCategories.defaultCategories, contains('Salary'));
      expect(AppCategories.defaultCategories, contains('Investments'));
      expect(AppCategories.defaultCategories, contains('Rent/Mortgage'));
      expect(AppCategories.defaultCategories, contains('Groceries'));
      expect(AppCategories.defaultCategories, contains('Utilities'));
      expect(AppCategories.defaultCategories, contains('Dining Out'));
      expect(AppCategories.defaultCategories, contains('Transportation'));
      expect(AppCategories.defaultCategories, contains('Entertainment'));
      expect(AppCategories.defaultCategories, contains('Shopping'));
      expect(AppCategories.defaultCategories, contains('Health/Medical'));
      expect(AppCategories.defaultCategories, contains('Education'));
      expect(AppCategories.defaultCategories, contains('Misc'));
      expect(AppCategories.defaultCategories.length, 12);
    });

    test('returns correct icons and colors for known and custom categories', () {
      expect(AppCategories.getIcon('Salary'), Icons.account_balance_wallet_outlined);
      expect(AppCategories.getIcon('Groceries'), Icons.shopping_cart_outlined);
      expect(AppCategories.getIcon('CustomCategory'), Icons.category_outlined);

      expect(AppCategories.getColor('Salary'), const Color(0xFF10B981));
      expect(AppCategories.getColor('CustomCategory'), const Color(0xFF64748B));
    });
  });
}
