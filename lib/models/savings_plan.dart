enum PlanFrequency { daily, weekly, biweekly, monthly }

enum PenaltyPolicy { monetaryDeduction, appRestriction, both }

class SavingsPlan {
  final String id;
  final String userId;
  final double amountPerPeriod;
  final PlanFrequency frequency;
  final int durationMonths;
  final DateTime startDate;
  final DateTime endDate;
  final PenaltyPolicy penaltyPolicy;
  final double goalAmount;
  final double currentAmount;
  final bool isActive;

  SavingsPlan({
    required this.id,
    required this.userId,
    required this.amountPerPeriod,
    required this.frequency,
    required this.durationMonths,
    required this.startDate,
    required this.endDate,
    required this.penaltyPolicy,
    this.goalAmount = 0,
    this.currentAmount = 0,
    this.isActive = true,
  });

  double get progressPercent =>
      goalAmount > 0 ? (currentAmount / goalAmount).clamp(0, 1) : 0;

  String get frequencyLabel {
    switch (frequency) {
      case PlanFrequency.daily:
        return 'Daily';
      case PlanFrequency.weekly:
        return 'Weekly';
      case PlanFrequency.biweekly:
        return 'Bi-Weekly';
      case PlanFrequency.monthly:
        return 'Monthly';
    }
  }

  factory SavingsPlan.fromJson(Map<String, dynamic> json) {
    return SavingsPlan(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      amountPerPeriod: (json['amount_per_period'] as num).toDouble(),
      frequency: PlanFrequency.values[json['frequency'] as int],
      durationMonths: json['duration_months'] as int,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      penaltyPolicy: PenaltyPolicy.values[json['penalty_policy'] as int],
      goalAmount: (json['goal_amount'] as num?)?.toDouble() ?? 0,
      currentAmount: (json['current_amount'] as num?)?.toDouble() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'amount_per_period': amountPerPeriod,
        'frequency': frequency.index,
        'duration_months': durationMonths,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'penalty_policy': penaltyPolicy.index,
        'goal_amount': goalAmount,
        'current_amount': currentAmount,
        'is_active': isActive,
      };
}
