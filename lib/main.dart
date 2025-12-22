import 'package:expense_manager/test_screen.dart';
import 'package:expense_manager/views/home/home_screen.dart';
import 'package:expense_manager/views/transaction/widgets/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'views/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:expense_manager/view_models/auth_view_model.dart';
import 'views/auth/auth_screen.dart';
import 'package:expense_manager/view_models/category_view_model.dart';
import 'package:expense_manager/view_models/transaction_view_model.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? ''
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (_) => TransactionViewModel()),
      ],
      child: const TestScreen(),
    )
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/auth': (context) => const AuthScreen(), // Thêm tham số onSwitch nếu cần 
        '/addTransaction': (context) => const AddTransaction(),
      },
    );
  }
}