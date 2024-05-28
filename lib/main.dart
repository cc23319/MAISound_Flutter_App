import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maisound/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Bench AI',
      home: HomePage(),
    );
  }
}

class MyAppState extends ChangeNotifier {}
