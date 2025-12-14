import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_manager/view_models/auth_view_model.dart';
import 'package:expense_manager/utils/dialog_utils.dart';


class RegisterScreen extends StatefulWidget {
  final VoidCallback onSwitch; // ham de chuyen sang form login
  const RegisterScreen({super.key, required this.onSwitch});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // cac bien nay theo doi du lieu nguoi dung nhap
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _isObscure = true; // bien de an hien mat khau
  bool _isObscureConfirm = true; // bien de an hien mat khau xac nhan

  @override
  // ham tu dong don dep tai nguyen khi widget bi huy
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  // ham xu ly su kien dang ki
  Future<void> _handleRegister() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    // hien thi dialog loading
    DialogUtils.showLoadingDialog(context);
    // goi ham signUp tu AuthViewModel
    final success = await context.read<AuthViewModel>().signUpAction(username, email, password, confirmPassword);
    if(!mounted) return; // kiem tra an toan truoc khi thao tac voi context
    // neu thanh cong
    if (success) {
      DialogUtils.switchLoadingToSuccess(context, message: "Registration Successful");
      await Future.delayed(Duration(seconds: 2));
      if(mounted){
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
    else{
      final errorMessage = context.read<AuthViewModel>().errorMessage ?? "Registration Failed";
      DialogUtils.switchLoadingToError(context, message: errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Register",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.person),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: _passwordController,
              obscureText: _isObscure,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            TextField(
              controller: _confirmPasswordController,
              obscureText: _isObscureConfirm,
              decoration: InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscureConfirm = !_isObscureConfirm;
                    });
                  },
                  icon: Icon(
                    _isObscureConfirm ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: _handleRegister,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  elevation: 8,
                ),
                child: Text("Register"),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                  onPressed: widget.onSwitch,
                  child: Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
