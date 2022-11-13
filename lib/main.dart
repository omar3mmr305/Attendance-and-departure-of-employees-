import 'package:flutter/material.dart';
import 'package:workapp/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF002B5B),
      )),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
