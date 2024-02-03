import 'package:flutter/material.dart';
import 'color_schemes.g.dart';
import 'package:lifelens/states/homescreen.dart';
import 'package:lifelens/states/pronounscreen.dart';
import 'package:lifelens/states/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeLens',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      // home: const HomeScreen(
      //   groupname: "Home",
      // ),
      home: const PronounScreen(
      ),
      // home: MyWidget(),
    );
  }
}
