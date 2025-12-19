import 'package:flutter/material.dart';

class AppIcon {
  static final Map<String, IconData> icons = {
    'food': Icons.fastfood,
    'transport': Icons.directions_car,
    'shopping': Icons.shopping_cart,
    'entertainment': Icons.movie,
    'bills': Icons.receipt,
    'health': Icons.health_and_safety,
    'travel': Icons.flight,
    'education': Icons.school,
    'gift': Icons.card_giftcard,
    'other': Icons.category,
  };
   // map icon
  static IconData getIcon(String? iconName) {
    return icons[iconName] ?? Icons.help_outline;
  }

  // set color tu name
  static Color getColor(String? iconName){
    switch(iconName){
      case 'food':
        return Color(0xFFFF9800);
      case 'transport':
        return Color(0xFF448AFF);
      case 'shopping':
        return Colors.purple;
      case 'entertainment':
        return Colors.red;
      case 'bills':
        return Colors.green;
      case 'health':
        return Color(0xFFFF4081);
      case 'travel':
        return Colors.teal;
      case 'education':
        return Colors.indigo;
      case 'gift':
        return Colors.yellow;
      case 'other':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}