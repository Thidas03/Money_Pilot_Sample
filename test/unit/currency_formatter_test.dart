import 'package:flutter_test/flutter_test.dart';
import 'package:moneypilot_mobile/core/utils/currency_formatter.dart';

void main() {
  group('CurrencyFormatter Tests', () {
    test('formats whole numbers with Rs. and commas', () {
      expect(CurrencyFormatter.format(25000), 'Rs. 25,000');
      expect(CurrencyFormatter.format(1000000), 'Rs. 1,000,000');
    });

    test('formats decimal numbers with 2 decimal places', () {
      expect(CurrencyFormatter.format(125500.5), 'Rs. 125,500.50');
      expect(CurrencyFormatter.format(450.75), 'Rs. 450.75');
    });

    test('forceDecimals forces .00 on integers', () {
      expect(CurrencyFormatter.format(25000, forceDecimals: true), 'Rs. 25,000.00');
    });

    test('formats null gracefully as Rs. 0', () {
      expect(CurrencyFormatter.format(null), 'Rs. 0');
    });

    test('compact format works as expected', () {
      expect(CurrencyFormatter.formatCompact(25000), 'Rs. 25K');
      expect(CurrencyFormatter.formatCompact(1500000), 'Rs. 1.5M');
    });

    test('parses formatted string back to double', () {
      expect(CurrencyFormatter.parse('Rs. 25,000'), 25000.0);
      expect(CurrencyFormatter.parse('Rs. 125,500.50'), 125500.50);
      expect(CurrencyFormatter.parse(''), null);
      expect(CurrencyFormatter.parse(null), null);
    });
  });
}
