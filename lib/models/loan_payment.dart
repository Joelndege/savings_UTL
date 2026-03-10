class LoanPayment {
  final String id;
  final String loanId;
  final double amountPaid;
  final DateTime paymentDate;
  final double remainingBalance;

  LoanPayment({
    required this.id,
    required this.loanId,
    required this.amountPaid,
    required this.paymentDate,
    required this.remainingBalance,
  });

  factory LoanPayment.fromJson(Map<String, dynamic> json) {
    return LoanPayment(
      id: json['id'] as String,
      loanId: json['loan_id'] as String,
      amountPaid: (json['amount_paid'] as num).toDouble(),
      paymentDate: DateTime.parse(json['payment_date'] as String),
      remainingBalance: (json['remaining_balance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'loan_id': loanId,
        'amount_paid': amountPaid,
        'payment_date': paymentDate.toIso8601String(),
        'remaining_balance': remainingBalance,
      };
}
