import 'package:flutter/material.dart';
import 'package:expense_manager/services/auth_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// class kiem tra dang nhap
class AuthViewModel extends ChangeNotifier {
  final AuthServices authServices = AuthServices();

  bool _isLoading = false;
  String? _errorMessage;

  // dung getter de view chi co the doc chu khong duoc sua
  User? get currentUser => authServices.currentUser; // getter cho currentUser
  bool get isLoading => _isLoading; // getter cho isLoading
  String? get errorMessage => _errorMessage; // getter cho errorMessage

  // validate email
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // validate o form Login
  String? validateLoginForm(String input,String password){
    if (input.isEmpty || password.isEmpty) {
      return "Please enter your username or email";
    }
    return null;
  }

  String? validateSignUpForm(String username,String email, String password, String confirmPassword){
    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return "Please fill in all fields";
    }
    if(!isValidEmail(email)){
      return "Please enter a valid email";
    }
    if (password != confirmPassword) {
      return "Passwords do not match";
    }
    if (password.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  // ham logic xu ly dang nhap
  Future<bool> logInAction(String input,String password) async{
    String? error = validateLoginForm(input, password);
    if(error != null){
      _errorMessage = error;
      notifyListeners();
      return false;
    }
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try{
      await authServices.signIn(input, password);
      _isLoading = false;
      notifyListeners();
      return true;
    }
    catch(e){
      _isLoading = false;
      if(e is AuthException){
        _errorMessage = e.message;
      }
      else{
        _errorMessage = 'Error occurred during login: $e';
      }
      notifyListeners();
      return false;
    }
  }

  // ham logic xu ly dang ki
  Future<bool> signUpAction(String username,String email, String password, String confirmPassword) async{
    String? error = validateSignUpForm(username, email, password, confirmPassword);
    if(error != null){
      _errorMessage = error;
      notifyListeners();
      return false;
    }
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try{
      await authServices.signUp(username, email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    }
    catch(e){
      _isLoading = false;
      if(e is AuthException){
        _errorMessage = e.message;
      }
      else{
        _errorMessage = 'Error occurred during sign up: $e';
      }
      notifyListeners();
      return false;
    }
  }

  // ham xu ly dang xuat
  Future<void> logOutAction() async{
    await authServices.signOut();
    notifyListeners();
  }
}

  