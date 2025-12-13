
class UserModel {
  final String id;
  final String username;
  final String? avatarUrl;
  final double currentMoney;
  
  UserModel({
    required this.id,
    required this.username,
    this.avatarUrl,
    required this.currentMoney,
  });
  
  // dua du lieu json tu supabase ve model
  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      id: json['id'], // truong id trong database
      username: json['username'] ?? '',  // neu khong co username thi tra ve chuoi rong
      avatarUrl: json['avatar_url'], // truong avatar_url trong database
      currentMoney: (json['current_money'] as num).toDouble(), // truong current_money trong database
    );
  }

  // ham dong goi du lieu lai thanh json de dua len supabase
  Map<String,dynamic> toJson(){
    return{
      'username': username, // truong username trong database se nhan gia tri tu bien username
      'avatar_url': avatarUrl, // truong avatar_url trong database se nhan gia tri tu bien avatarUrl
      'current_money': currentMoney, // truong current_money trong database se nhan gia tri tu bien currentMoney
    };
  }
}