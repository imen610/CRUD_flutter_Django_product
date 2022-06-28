import 'package:crud/index.dart';
import 'package:crud/theme/theme_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme : ThemeData(primaryColor: primary),
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
    );
  }
}
