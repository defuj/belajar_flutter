import 'package:belajar_flutter/page/form.dart';
import 'package:belajar_flutter/page/home.dart';
import 'package:belajar_flutter/page/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => FormPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
      },
      initialRoute: '/',
    );
  }
}
