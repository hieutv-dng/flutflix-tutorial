import 'package:firebase_core/firebase_core.dart';
import 'package:flutflix/components/index.dart';
import 'package:flutflix/data/index.dart';
import 'package:flutflix/firebase_options.dart';
import 'package:flutflix/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put<AuthService>(AuthService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutflix',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: MyColors.scaffoldBgColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: MyColors.scaffoldBgColor,
        ),
      ),
      home: const MainPage(),
      builder: EasyLoading.init(),
    );
  }
}
