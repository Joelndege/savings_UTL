enum LoanStatus { pending, approved, active, repaid, defaulted }

class Loan {
  final String id;
  final String userId;
  final double amount;
  final double interestRate;
  final int durationMonths;
  final LoanStatus status;
  final DateTime? approvedDate;
  final DateTime? dueDate;
  final double totalRepaid;

  Loan({
    required this.id,
    required this.userId,
    required this.amount,
    this.interestRate = 10.0,
    required this.durationMonths,
    this.status = LoanStatus.pending,
    this.approvedDate,
    this.dueDate,
    this.totalRepaid = 0,
  });

  double get totalWithInterest => amount * (1 + interestRate / 100);
  double get monthlyPayment => totalWithInterest / durationMonths;
  double get remainingBalance => totalWithInterest - totalRepaid;
  double get repaymentProgress =>
      totalWithInterest > 0 ? (totalRepaid / totalWithInterest).clamp(0, 1) : 0;

  String get statusLabel {
    switch (status) {
      case LoanStatus.pending:
        return 'Pending';
      case LoanStatus.approved:
        return 'Approved';
      case LoanStatus.active:
        return 'Active';
      case LoanStatus.repaid:
        return 'Repaid';
      case LoanStatus.defaulted:
        return 'Defaulted';
    }
  }

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      interestRate: (json['interest_rate'] as num?)?.toDouble() ?? 10.0,
      durationMonths: json['duration_months'] as int,
      status: LoanStatus.values[json['status'] as int? ?? 0],
      approvedDate: json['approved_date'] != null
          ? DateTime.parse(json['approved_date'] as String)
          : null,
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date'] as String)
          : null,
      totalRepaid: (json['total_repaid'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'amount': amount,
        'interest_rate': interestRate,
        'duration_months': durationMonths,
        'status': status.index,
        'approved_date': approvedDate?.toIso8601String(),
        'due_date': dueDate?.toIso8601String(),
        'total_repaid': totalRepaid,
      };
}
