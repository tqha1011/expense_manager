import 'package:expense_manager/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/services/transactions_services.dart';

class TransactionViewModel extends ChangeNotifier{
  final TransactionsServices transactionsServices = TransactionsServices();
  List<TransactionModel> _transactions = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage; 
  List<TransactionModel> get transactions => _transactions;

  String? validateTransactionInfo(String note, String amount, int categoriesId){
    if(note.isEmpty || amount.isEmpty || categoriesId == -1){
      return "Please fill in all fields";
    }
    if(double.tryParse(amount) == null){
      return "Please enter a valid amount";
    }
    return null;
  }

  Future<void> getAllTransaction(String userId) async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try{
      List<TransactionModel> data = await transactionsServices.getTransactionsByUserId(userId);
      _transactions = data;
      _isLoading = false;
      notifyListeners();
    }
    catch(error){
      _isLoading = false;
      _errorMessage = error.toString();
      notifyListeners();
    }
  }


  Future<bool> addTransactionAction(String note,String amount,String userId,int categoriesId,DateTime day) async{
    String? error = validateTransactionInfo(note, amount,categoriesId);
    if(error != null){
      _errorMessage = error;
      notifyListeners();
      return false;
    }
    TransactionModel trans = TransactionModel(
      id: 0,
      title: null,
      date: day,
      amount: double.parse(amount),
      categoriesID: categoriesId,
      note: note,
    );

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try{
      await transactionsServices.addTransaction(trans, userId, categoriesId); // them giao dich vao database
      await getAllTransaction(userId); // tai lai danh sach giao dich
      _isLoading = false;
      notifyListeners();
      return true;
    }
    catch(error){
      _isLoading = false;
      _errorMessage = error.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteTransactionAction(int transactionId,String userId) async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try{
      await transactionsServices.deleteTransaction(transactionId); // xoa giao dich khoi database
      await getAllTransaction(userId); // tai lai danh sach giao dich
      _isLoading = false;
      notifyListeners();
      return true;
    }
    catch(error){
      _isLoading = false;
      _errorMessage = error.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> filterTransactionAction(String userId,{int categoriesId = 0,DateTime? date}) async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try{
      List<TransactionModel> data = await transactionsServices.filterTransactions(categoriesId: categoriesId, date: date);
      _transactions = data;
      _isLoading = false;
      notifyListeners();
    }
    catch(error){
      _isLoading = false;
      _errorMessage = error.toString();
      notifyListeners();
    }
  }
}
