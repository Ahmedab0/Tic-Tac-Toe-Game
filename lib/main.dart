import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,primary: Colors.blue,background: const Color(0xffDCDCDC)),
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        canvasColor: const Color(0xffDCDCDC),
        primaryColor: const Color(0xff00061a),
        shadowColor: const Color(0xff001456),
        splashColor: const Color(0xff4169e8),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
