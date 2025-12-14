import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_manager/view_models/auth_view_model.dart';
import 'package:expense_manager/views/auth/password_recovery.dart';


// form login
class LoginScreen extends StatefulWidget {
  final VoidCallback onSwitch; // ham de chuyen sang form register
  const LoginScreen({super.key, required this.onSwitch});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // controller de lay du lieu nguoi dung nhap
  final _inputController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true; // bien de an hien mat khau
  bool _rememberMe = false; // bien de luu trang thai remember me

  @override
  // ham tu dong don dep tai nguyen khi widget bi huy
  void dispose() {
    _inputController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              "Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: "Email or Username",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.emailAddress,
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
            Row(
              children: [
                SizedBox(
                  child: Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    activeColor: Colors.green,
                  ),
                ),
                SizedBox(width: 8),
                Text("Remember Me"),
                SizedBox(width: 53),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Text("Forgot Password?"),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  final input = _inputController.text.trim();
                  final password = _passwordController.text.trim();

                  // goi ham login tu AuthViewModel
                  final success = await context
                      .read<AuthViewModel>()
                      .logInAction(input, password);
                  if (success && context.mounted) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  elevation: 8,
                ),
                child: Text("Login"),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: widget.onSwitch,
                  child: Text("Register"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
