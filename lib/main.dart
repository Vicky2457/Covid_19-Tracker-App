import 'package:covid_19/covid_19_Api/view/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            titleSmall: TextStyle(fontSize: 31, fontWeight: FontWeight.bold),
          )),
      home: const Splash(),
    );
  }
}
