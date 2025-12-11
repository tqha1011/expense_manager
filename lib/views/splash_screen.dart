import 'package:expense_manager/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:expense_manager/views/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState(){
    super.initState();
    redirect();
  }

  Future<void> redirect() async{
    await Future.delayed(Duration(seconds: 2));

    // kiem tra phien dang nhap
    final session = Supabase.instance.client.auth.currentSession;

    // neu man hinh nay khong ton tai thi khong lam gi nua
    if(!mounted) return;

    // if(session != null){
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (_) => HomeScreen()) // neu da co dang nhap truoc thi vao thang home screen
    //   );
    // }
    // else{
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (_) => LoginScreen()) // neu chua dang nhap thi vao Login Screen
    //   );
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark, // cho thong so pin , mang thanh mau den
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/money.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),

            SizedBox(height: 20,),
            Text(
              "Welcome back!",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}