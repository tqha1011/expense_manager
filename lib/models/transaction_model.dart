
// lay nhung thu can thiet tren database ve model
class TransactionModel {
  final int id;
  final String? title;
  final double amount;
  final DateTime date;
  final String note;
  final int categoriesID;
  final int? eventID;
  
  TransactionModel({
    required this.id,
    this.title,
    required this.date,
    required this.amount,
    required this.categoriesID,
    required this.note,
    this.eventID
  });

  // ham factory de chuyen du lieu trong file JSON lay tu Supabase ve do vao TransactionModel
  factory TransactionModel.fromJson(Map<String,dynamic> json){
    return TransactionModel(
      id: json['id'], 
      title: json['title'] ?? '', 
      amount: (json['amount'] as num).toDouble(), 
      date: json['date'],
      categoriesID: json['category_id'],
      eventID: json['event_id'],
      note: json['note']
    );
  }

  // map du lieu tu json
  // ben trai la cot trong database
  // ben phai la bien trong model
  Map<String,dynamic> toJson(){
    return {
      'title': title,
      'amount': amount,
      'date' : date.toIso8601String(),
      'note' : note,
      'category_id': categoriesID,
      'event_id': eventID
    };
  }
}