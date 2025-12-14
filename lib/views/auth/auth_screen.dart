import 'package:expense_manager/views/auth/login_screen.dart';
import 'package:expense_manager/views/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // 👇 Biến quyết định đang hiện form nào
  bool _isLogin = true; 

  // Hàm để đổi trạng thái (truyền xuống cho con dùng)
  void toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black, 
        body: Stack(
          children: [
            // giu anh nen dung yen
            Positioned.fill(
              child: Image.asset(
                'assets/images/loginbackground.jpg',
                fit: BoxFit.cover,
              ),
            ),
      
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  
                  // AnimatedSwitcher để chuyển đổi giữa 2 form với hiệu ứng
                  child: PageTransitionSwitcher(
                    duration: const Duration(milliseconds: 500),
                    reverse: _isLogin, // Đảo chiều hiệu ứng khi quay về Login
                    transitionBuilder: (child, animation, secondaryAnimation) {
                      return SharedAxisTransition(
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        // Kiểu hiệu ứng:
                        // .horizontal: Trượt ngang (giống chuyển trang sách)
                        // .scaled: Phóng to/Thu nhỏ (giống popup - Rất đẹp cho Card)
                        // .vertical: Trượt dọc
                        transitionType: SharedAxisTransitionType.horizontal, 
                        fillColor: Colors.transparent, // Để không bị nền trắng che mất ảnh background
                        child: child,
                      );
                    },
                    
                    // Nếu là Login thì hiện LoginForm, ngược lại hiện RegisterForm
                    child: _isLogin 
                        ? LoginScreen(key: const ValueKey("Login"), onSwitch: toggleAuthMode)
                        : RegisterScreen(key: const ValueKey("Register"), onSwitch: toggleAuthMode),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}