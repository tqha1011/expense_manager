import 'package:flutter/material.dart';
import 'package:expense_manager/utils/format_input.dart';  

// xay dung widget giao dich
class TransactionItem extends StatefulWidget {
  final double amount;
  final String note;
  final DateTime date;
  final bool isIncome;
  final IconData icon;

  // cac bien truyen vao de hien thi giao dich
  const TransactionItem({
    super.key,
    required this.amount,
    required this.date,
    required this.isIncome,
    required this.icon,
    required this.note,
  });

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        isThreeLine: true,
        leading: CircleAvatar(
          radius: 25,
          child: Icon(
            widget.icon,
            size: 30,
          ), // dung widget.icon de hien thi icon truyen vao
        ),
        title: Text(
          widget.note,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          Format.formatDate(widget.date), // hien thi ngay thang va ghi chu
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        trailing: Text(
          (widget.isIncome ? '+' : '-') + Format.formatCurrency(widget.amount), // format tien te
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: widget.isIncome ? Colors.green : Colors.red,
          ),
        ),
        onTap: () => {
          // xu ly su kien khi nhan vao giao dich
        },
      ),
    );
  }
}
