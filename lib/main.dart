import 'package:app_teste/RouteGenerator/Routes.dart';
import 'package:app_teste/telas/TelaHome.dart';
import 'package:flutter/material.dart';

void main() async {

  

  

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override

  MyApp();

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Home(),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
