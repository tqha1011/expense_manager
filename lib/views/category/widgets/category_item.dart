import 'package:flutter/material.dart';
import 'package:expense_manager/models/categories_model.dart';
import 'package:expense_manager/utils/app_icon.dart';

class CategoryItem extends StatefulWidget {
  final CategoriesModel category;
  const CategoryItem({
    super.key,
    required this.category,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: AppIcon.getColor(widget.category.iconUrl),
          child: Icon(
            AppIcon.getIcon(widget.category.iconUrl),
            size: 30,
            color: Colors.black,
          ), // hien thi icon cua category
        ),
        title: Text(
          widget.category.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onTap: (){
          Navigator.pop(context, widget.category);
        },
      ),
    );
  }
}