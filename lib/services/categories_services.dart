import 'package:expense_manager/models/categories_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoriesServices {
  final SupabaseClient supabaseClient = Supabase.instance.client;

  // ham lay danh sach categories theo khoan chi hay la khoan thu
  Future<List<CategoriesModel>> getCategoriesByType(bool isIncome) async {
    try{
      final response = await supabaseClient
          .from('categories')
          .select()
          .eq('is_income', isIncome)
          .order('name', ascending: true); // lay ve va sap xep theo ten
      List<CategoriesModel> categories = (response as List)
          .map((item) => CategoriesModel.fromJson(item))
          .toList();
      return categories;
    }
    catch(e){ 
      return [];
    }
  }
}