class Penalty {
  final String id;
  final String userId;
  final String? planId;
  final double amount;
  final String reason;
  final DateTime date;
  final bool isApplied;

  Penalty({
    required this.id,
    required this.userId,
    this.planId,
    required this.amount,
    required this.reason,
    required this.date,
    this.isApplied = true,
  });

  factory Penalty.fromJson(Map<String, dynamic> json) {
    return Penalty(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      planId: json['plan_id'] as String?,
      amount: (json['amount'] as num).toDouble(),
      reason: json['reason'] as String,
      date: DateTime.parse(json['date'] as String),
      isApplied: json['is_applied'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'plan_id': planId,
        'amount': amount,
        'reason': reason,
        'date': date.toIso8601String(),
        'is_applied': isApplied,
      };
}
