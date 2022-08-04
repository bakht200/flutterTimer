import 'package:flutter/material.dart';
import 'package:flutter_timer/binding.dart';
import 'package:flutter_timer/utils/utils.dart';
import 'package:flutter_timer/view/home_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MyBindings(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Timer',
      darkTheme: MyThemes.darkTheme,
      themeMode: ThemeMode.light,
      theme: MyThemes.lightTheme,
      home: const HomePage(),
    );
  }
}
