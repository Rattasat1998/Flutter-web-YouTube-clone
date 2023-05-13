import 'package:flutter/material.dart';
import 'package:youtube_clone/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Clone',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}


