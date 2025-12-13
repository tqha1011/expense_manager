import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:expense_manager/models/transaction_model.dart';

class TransactionsServices {
  final SupabaseClient supabaseClient = Supabase.instance.client;

  // ham lay danh sach giao dich theo user id
  // khi load vao home screen thi can load tat ca giao dich cua user do
  Future<List<TransactionModel>> getTransactionsByUserId(String userId) async {
    try{
      final response = await supabaseClient
          .from('transactions')
          .select()
          .eq('user_id', userId)
          .order('date', ascending: false); // lay ve va sap xep theo ngay giao dich
      List<TransactionModel> transactions = (response as List)
          .map((item) => TransactionModel.fromJson(item))
          .toList();
      return transactions;
    }
    catch(e){
      return [];
    }
  }

  // ham them giao dich moi
  // dung cac phuong thuc toJson de chuyen doi du lieu
  Future<void> addTransaction(TransactionModel trans,String userId,int categoriesId) async {
    try{
      final Map<String,dynamic> data = trans.toJson();
      data['user_id'] = userId;
      data['category_id'] = categoriesId;
      await supabaseClient.from('transactions').insert(data);
    }
    catch(e){
      throw Exception('Failed to add transaction: $e');
    }
  }

  // ham xoa giao dich
  // nhan tham so la id cua giao dich can xoa 
  Future<void> deleteTransaction(int transactionId) async {
    try{
      await supabaseClient.from('transactions')
          .delete()
          .eq('id', transactionId);
    }
    catch(e){
      throw Exception('Failed to delete transaction: $e');
    }
  }

  // update transaction
  Future<void> updateTransaction(TransactionModel trans,int categoriesID) async{
    try{
      final Map<String,dynamic> data = trans.toJson();
      data['categories_id'] = categoriesID;
      await supabaseClient.from('transactions').update(data).eq('id', trans.id);
    }
    catch(e){
      throw Exception('Failed to update transaction: $e');
    }
  }

  // ham loc theo yeu cau cua user
  // dung cach dynamic query de loc theo nhieu tieu chi khac nhau
  Future<List<TransactionModel>> filterTransactions({int categoriesId = 0,DateTime? date}) async{
    try{
      var query = supabaseClient.from('transactions').select();

      if(categoriesId != 0){
        query = query.eq('category_id', categoriesId);
      }

      if(date != null){
        final startofMonth = DateTime(date.year, date.month, 1);
        final endofMonth = DateTime(date.year,date.month + 1, 1);
        query = query.gte('date', startofMonth.toIso8601String()).lt('date',endofMonth.toIso8601String());
      }
      final response = await query.order('date', ascending: false);
      return (response as List).map((item) => TransactionModel.fromJson(item)).toList();
    }
    catch(e){
      return [];
    }
  }

  // ham lay chi tiet giao dich theo id
  Future<TransactionModel> getTransactionDetails(int transactionId) async{
    try{
      final response = await supabaseClient // cho supabaseclient lay du lieu
          .from('transactions')
          .select()
          .eq('id', transactionId)
          .single();
      return TransactionModel.fromJson(response); // chuyen du lieu tu json ve model
    }
    catch(e){
      throw Exception('Failed to get transaction details: $e');
    }
  }
}