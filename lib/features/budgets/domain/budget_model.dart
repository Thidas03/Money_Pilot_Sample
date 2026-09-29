/// Budget data model for category and overall targets.
class Budget {
  final String id;
  final String category;
  final double amount;
  final String period;
  final String? note;
  final DateTime createdAt;

  const Budget({
    required this.id,
    required this.category,
    required this.amount,
    this.period = 'Monthly',
    this.note,
    required this.createdAt,
  });

  bool get isOverall => category.toLowerCase() == 'overall' || category.toLowerCase() == 'monthly';

  Budget copyWith({
    String? id,
    String? category,
    double? amount,
    String? period,
    String? note,
    DateTime? createdAt,
  }) {
    return Budget(
      id: id ?? this.id,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      period: period ?? this.period,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'period': period,
      'note': note,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Budget.fromJson(Map<String, dynamic> map) {
    return Budget(
      id: map['id'] as String,
      category: map['category'] as String,
      amount: (map['amount'] as num).toDouble(),
      period: map['period'] as String? ?? 'Monthly',
      note: map['note'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}
