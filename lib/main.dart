import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://htwzciiryzxjxpwiuvhw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh0d3pjaWlyeXp4anhwd2l1dmh3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUzNTYxMjEsImV4cCI6MjA4MDkzMjEyMX0.R5CzJ2tYdPq4PsyoqfOy8jjpagALYS0zYgC8iTQnBno'
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Connect supabase",
      home: Scaffold(
        body: Center(
          child: Text("Connect successfully"),
        ),
      ),
    );
  }
}