import 'package:flutter/material.dart';
import 'package:expense_manager/views/category/widgets/category_item.dart';
import 'package:expense_manager/models/categories_model.dart';
import 'package:expense_manager/view_models/category_view_model.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final bool isIncome;
  const CategoryScreen({super.key, required this.isIncome});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<CategoriesModel> categories;
  @override
  void initState(){
    super.initState();
    // load danh sach category tu view model
    context.read().categoryViewModel.getCategoriesByType(widget.isIncome);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
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
                        'Categories',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.add, color: Colors.white, size: 30),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<CategoryViewModel>(
              builder: (context, categoryViewModel, child) {
                categories = categoryViewModel.categories;
                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryItem(category: categories[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
