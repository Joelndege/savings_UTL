enum TransactionType { deposit, penaltyDeduction, interestReward, withdrawal }

enum TransactionStatus { pending, completed, failed }

class SavingsTransaction {
  final String id;
  final String userId;
  final String? planId;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final TransactionStatus status;
  final String? description;

  SavingsTransaction({
    required this.id,
    required this.userId,
    this.planId,
    required this.amount,
    required this.date,
    required this.type,
    this.status = TransactionStatus.completed,
    this.description,
  });

  String get typeLabel {
    switch (type) {
      case TransactionType.deposit:
        return 'Deposit';
      case TransactionType.penaltyDeduction:
        return 'Penalty';
      case TransactionType.interestReward:
        return 'Interest';
      case TransactionType.withdrawal:
        return 'Withdrawal';
    }
  }

  bool get isCredit =>
      type == TransactionType.deposit ||
      type == TransactionType.interestReward;

  factory SavingsTransaction.fromJson(Map<String, dynamic> json) {
    return SavingsTransaction(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      planId: json['plan_id'] as String?,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      type: TransactionType.values[json['type'] as int],
      status: TransactionStatus.values[json['status'] as int? ?? 1],
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'plan_id': planId,
        'amount': amount,
        'date': date.toIso8601String(),
        'type': type.index,
        'status': status.index,
        'description': description,
      };
}
