import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_app/Screens/home.dart';
import 'package:health_app/Database/lists.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataBank1(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home(),
    );
  }
}
