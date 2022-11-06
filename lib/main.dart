import 'package:flutter/material.dart';
import 'package:food_recipe/database/helper.dart';
import 'package:food_recipe/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RecipesHelper.instance.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

