import 'package:covid_tracker_app/datasorce.dart';
import 'package:covid_tracker_app/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: primaryBlack),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
