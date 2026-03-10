class InterestDistribution {
  final String loanId;
  final double totalInterest;
  final double userSavingsShare;
  final double platformShare;

  InterestDistribution({
    required this.loanId,
    required this.totalInterest,
    required this.userSavingsShare,
    required this.platformShare,
  });

  factory InterestDistribution.fromJson(Map<String, dynamic> json) {
    return InterestDistribution(
      loanId: json['loan_id'] as String,
      totalInterest: (json['total_interest'] as num).toDouble(),
      userSavingsShare: (json['user_savings_share'] as num).toDouble(),
      platformShare: (json['platform_share'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'loan_id': loanId,
        'total_interest': totalInterest,
        'user_savings_share': userSavingsShare,
        'platform_share': platformShare,
      };
}
