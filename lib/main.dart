
import 'login.dart';

import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'O\'Kazan',
      home: LoginPage(),
      //theme: new ThemeData(scaffoldBackgroundColor: Colors.cyanAccent),
    );
  }
}
