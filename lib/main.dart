import 'package:flutter/material.dart';
import 'package:lab_3_update/cards_screan.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: UsersScreen()
    );
  }
}
