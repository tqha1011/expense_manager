import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:expense_manager/utils/build_widget.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _moneyController = TextEditingController();
  bool isIncome = false;
  final _categoryController = TextEditingController();
  final _noteController = TextEditingController();
  final _dateController = TextEditingController(
    text: DateFormat('dd/MM/yyyy').format(DateTime.now()),
  );
  int? _selectedSegment = 0;

  @override
  // ham don dep tai nguyen
  void dispose() {
    _moneyController.dispose();
    _categoryController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: CupertinoSlidingSegmentedControl(
                  children: {
                    0: BuildWidget.buildSegment('Expense'),
                    1: BuildWidget.buildSegment('Income'),
                  },
                  groupValue: _selectedSegment,
                  thumbColor: _selectedSegment == 0 ? Colors.red : Colors.green,
                  onValueChanged: (int? value) {
                    setState(() {
                      _selectedSegment = value;
                      value == 1 ? isIncome = true : isIncome = false; // cap nhat loai giao dich
                    });
                  },
                ),
              ),
            ),
            TextField(
              controller:
                  _moneyController, // set controller de lay du lieu nguoi dung nhap
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Money',
                border: OutlineInputBorder(),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('₫', style: TextStyle(fontSize: 25)),
                ),
              ),
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 5),

            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
                suffixIcon: IconButton(
                  // TODO:se chuyen qua catgory screen de chon category
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ),
              ),
              // TODO:set onTap de xu ly su kien nhan vao cung chuyen qua category
              onTap: () => {},
            ),
            SizedBox(height: 10),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Note',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
              ),
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 10),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
                suffixIcon: IconButton(
                  // TODO: se hien thi date picker de chon ngay thang
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ),
              ),

              // TODO: set onTap de xu ly su kien nhan vao cung hien thi date picker
              onTap: () => {},
            ),

            SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                // TODO: ham async de luu giao dich vao database
                onPressed: () {}, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
