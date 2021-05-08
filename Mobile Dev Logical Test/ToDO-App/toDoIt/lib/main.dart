import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toDoIt/constants.dart';
import 'package:toDoIt/splash_screen.dart';

import 'list_provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
      create: (context) => ListProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do It',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: kBack,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}


