import 'package:flutter/material.dart';
import 'home_screen.dart';  // Import the HomeScreen file
import 'sign_up_screen.dart';
import 'login_screen.dart';
import 'register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
    );
  }
}