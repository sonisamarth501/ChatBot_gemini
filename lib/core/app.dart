import 'package:flutter/material.dart';
import 'package:flutter_bot/presentation/chat_home_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();
  static MyApp instance = const MyApp._internal();

  @override
  State<MyApp> createState() => _MyAppState();

  factory MyApp() => instance;
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData.dark(),
    );
  }
}
