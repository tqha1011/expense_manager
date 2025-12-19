import 'package:expense_manager/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/services/categories_services.dart';

class CategoryViewModel extends ChangeNotifier{
  List<CategoriesModel> _categories = [];
  bool _isLoading = false;
  final CategoriesServices categoriesServices = CategoriesServices();
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage; 
  List<CategoriesModel> get categories => _categories;

  Future<void> getCategoriesByType(bool isIncome) async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try{
      List<CategoriesModel> data = await categoriesServices.getCategoriesByType(isIncome);
      _categories = data;
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