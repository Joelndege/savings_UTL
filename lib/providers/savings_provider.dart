import 'package:flutter/material.dart';
import '../models/savings_plan.dart';
import '../models/savings_transaction.dart';
import '../models/penalty.dart';
import '../services/api_service.dart';

class SavingsProvider with ChangeNotifier {
  final ApiService _api = ApiService();
  List<SavingsPlan> _plans = [];
  List<SavingsTransaction> _transactions = [];
  List<Penalty> _penalties = [];
  bool _isLoading = false;
  String? _error;

  List<SavingsPlan> get plans => _plans;
  List<SavingsTransaction> get transactions => _transactions;
  List<Penalty> get penalties => _penalties;
  bool get isLoading => _isLoading;
  String? get error => _error;

  double get totalSavings =>
      _transactions
          .where((t) => t.isCredit && t.status == TransactionStatus.completed)
          .fold(0.0, (sum, t) => sum + t.amount) -
      _transactions
          .where((t) => !t.isCredit && t.status == TransactionStatus.completed)
          .fold(0.0, (sum, t) => sum + t.amount);

  double get totalPenalties =>
      _penalties.where((p) => p.isApplied).fold(0.0, (sum, p) => sum + p.amount);

  Future<void> loadData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final plansData = await _api.getSavingsPlans();
      _plans = plansData.map((json) => SavingsPlan.fromJson(
        _normalizeKeys(json as Map<String, dynamic>),
      )).toList();

      final txnData = await _api.getTransactions();
      _transactions = txnData.map((json) => SavingsTransaction.fromJson(
        _normalizeKeys(json as Map<String, dynamic>),
      )).toList();

      final penData = await _api.getPenalties();
      _penalties = penData.map((json) => Penalty.fromJson(
        _normalizeKeys(json as Map<String, dynamic>),
      )).toList();
    } catch (e) {
      _error = 'Failed to load savings data';
      // Fall back to empty lists — the UI will still render
      _plans = [];
      _transactions = [];
      _penalties = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addPlan(SavingsPlan plan) async {
    try {
      await _api.createSavingsPlan(plan.toJson());
      await loadData(); // Refresh
      return true;
    } catch (e) {
      _error = 'Failed to create savings plan';
      notifyListeners();
      return false;
    }
  }

  Future<bool> addDeposit(SavingsTransaction transaction) async {
    try {
      await _api.createDeposit({
        'amount': transaction.amount,
        'type': 'DEPOSIT',
        'status': 'COMPLETED',
        'plan': transaction.planId,
        'description': transaction.description ?? 'Savings deposit',
      });
      await loadData(); // Refresh
      return true;
    } catch (e) {
      _error = 'Failed to record deposit';
      notifyListeners();
      return false;
    }
  }

  /// Normalize API keys to match model expectations
  Map<String, dynamic> _normalizeKeys(Map<String, dynamic> json) {
    // Map Django field names to Flutter model expected names
    final normalized = Map<String, dynamic>.from(json);
    // Ensure 'id' is a String
    if (normalized['id'] != null) {
      normalized['id'] = normalized['id'].toString();
    }
    if (normalized['user'] != null) {
      normalized['user_id'] = normalized['user'].toString();
    }
    if (normalized['plan'] != null) {
      normalized['plan_id'] = normalized['plan'].toString();
    }
    // Map timestamp → date for SavingsTransaction
    if (normalized.containsKey('timestamp') && !normalized.containsKey('date')) {
      normalized['date'] = normalized['timestamp'];
    }
    return normalized;
  }
}
