import 'package:flutflix/components/index.dart';
import 'package:flutflix/my_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutflix',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: MyColors.scaffoldBgColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: MyColors.scaffoldBgColor,
        ),
      ),
      home: const HomePage(),
    );
  }
}
