import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screen_login/login_screen.dart';
import 'package:food_app/screen_main_page/add_food.dart';
import 'package:food_app/Table_screen/Table1/Table1_price_scren.dart';
import 'package:food_app/screen_main_page/home_screen.dart';
import 'package:food_app/test/test.dart';
import 'package:provider/provider.dart';
import 'Tab/side_dish_tab.dart';
import 'Table_screen/table_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp // เมทเมียเรียลแอป คือหน้าเเรกที่แสดงผล
        (
      debugShowCheckedModeBanner: false,
      home: TaBleScreen(), // โดยระบุผ่าน Home ว่าอยากให้แสดงผลอะไร
    );
  }
}
