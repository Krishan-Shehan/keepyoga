import 'package:flutter/material.dart';
import 'package:keepyoga/features/auth/ui/loginUi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF6B4EFF,
          <int, Color>{
            50: Color(0xFFE8EAF6),
            100: Color(0xFFC5CAE9),
            200: Color(0xFF9FA8DA),
            300: Color(0xFF7986CB),
            400: Color(0xFF5C6BC0),
            500: Color(0xFF3F51B5),
            600: Color(0xFF394AAE),
            700: Color(0xFF3140A5),
            800: Color(0xFF29379D),
            900: Color(0xFF1B27A0),
          },
        ),
      ),
      home: LoginUi(),
    );
  }
}
