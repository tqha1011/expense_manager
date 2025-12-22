import 'package:expense_manager/models/categories_model.dart';
import 'package:expense_manager/view_models/auth_view_model.dart';
import 'package:expense_manager/view_models/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:expense_manager/utils/build_widget.dart';
import 'package:intl/intl.dart';
import 'package:expense_manager/views/category/category_screen.dart';
import 'package:expense_manager/utils/app_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expense_manager/utils/dialog_utils.dart';
import 'package:provider/provider.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _moneyController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool isIncome = false;
  final _categoryController = TextEditingController();
  final _noteController = TextEditingController();
  final _dateController = TextEditingController(
    text: DateFormat('dd/MM/yyyy').format(DateTime.now()),
  );
  int? _selectedSegment = 0;
  CategoriesModel? _selectedCategory;

  @override
  // ham don dep tai nguyen
  void dispose() {
    _moneyController.dispose();
    _categoryController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    super.dispose();
  }
  Future<void> _selectCategory() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(isIncome: isIncome),
      ),
    );
    if (result != null && result is CategoriesModel) {
      setState(() {
        _selectedCategory = result;
        _categoryController.text = _selectedCategory!.name;
      });
    }
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context, 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100),
    );
    if(picked != null && picked != _selectedDate){
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
      });
    }
  }

  Future<void> _addTransaction() async{
    final note = _noteController.text.trim();
    final amount = _moneyController.text.trim();
    final categoriesId = _selectedCategory?.id ?? -1;
    final day = _dateController.text.trim();
    DialogUtils.showLoadingDialog(context);
    // goi ham them giao dich tu TransactionViewModel
    final result = await context.read<TransactionViewModel>().addTransactionAction(
      note,
      amount,
      context.read<AuthViewModel>().currentUser!.id,
      categoriesId,
      day == '' ? DateTime.now() : DateFormat('dd/MM/yyyy').parse(day),
    );
    if(!mounted) return;
    if(result){
      DialogUtils.switchLoadingToSuccess(context, message: "Transaction Added Successfully");
      await Future.delayed(Duration(seconds: 2));
      if(mounted){
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
    else{
        final errormessage = context.read<TransactionViewModel>().errorMessage ?? "Failed to add transaction";
        DialogUtils.switchLoadingToError(context, message: errormessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2af598), Color(0xFF009EFD)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                bottom: 5,
                left: 5,
                right: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Add Transaction',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
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
                    onTap: _selectCategory,
                    controller: _categoryController,
                    decoration: InputDecoration(
                      labelText: _selectedCategory == null ? 'Select Category' : _selectedCategory!.name,
                      border: OutlineInputBorder(),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: _selectedCategory == null ? FaIcon(FontAwesomeIcons.tags) : Icon(AppIcon.getIcon(_selectedCategory!.iconUrl)),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      labelText: 'Note',
                      border: OutlineInputBorder(),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: FaIcon(FontAwesomeIcons.noteSticky),
                      ),
                    ),
                    style: TextStyle(fontSize: 18),
                  ),
          
                  SizedBox(height: 10),
                  TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: FaIcon(FontAwesomeIcons.calendar),
                      ),
                      suffixIcon: IconButton(
                        onPressed: _selectDate,
                        icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      ),
                    ),
                    readOnly: true,
                    onTap: _selectDate,
                  ),
          
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addTransaction, 
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
          ),
        ],
      ),
    );
  }
}
