import 'package:flutter/material.dart';
//import 'package:maisound/home_page.dart';
import 'package:maisound/track_page.dart';
import 'package:maisound/home_page2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MAISound',
      home: TrackPage(),
    );
  }
}

class MyAppState extends ChangeNotifier {}
