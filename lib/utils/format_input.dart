import 'package:intl/intl.dart';

// ham format tien te
class Format {
  static String formatCurrency(dynamic amount){
    double number = 0;
    if(amount is String){
      number = double.tryParse(amount) ?? 0;
    }
    else{
      number = amount.toDouble();
    }

    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(number);
  }

  static String formatDate(DateTime date){
    return DateFormat('dd/MM/yyyy').format(date);
  }
}