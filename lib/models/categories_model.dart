class CategoriesModel {
  final int id;
  final String name;
  final bool isIncome;
  final String? iconUrl;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.isIncome,
    this.iconUrl,
  });

  // ham factory de chuyen du lieu trong file JSON lay tu Supabase ve do vao CategoriesModel
  factory CategoriesModel.fromJson(Map<String,dynamic> json){
    return CategoriesModel(
      id: json['id'],
      name: json['name'] ?? '',
      isIncome: json['is_income'] ?? false,
      iconUrl: json['icon'],
    );
  }

  // ham dong goi du lieu cua catgories lai thanh json de dua len supabase
  Map<String,dynamic> toJson(){
    return{
      'name': name,
      'is_income': isIncome,
      'icon': iconUrl,
    };
  }
}