import 'package:dvcdirectory/screens/splash.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() => runApp(BaseHome());

class BaseHome extends StatefulWidget {

  @override
  _BaseHomeState createState() => _BaseHomeState();
}

class _BaseHomeState extends State<BaseHome> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LogoAnimate(),
      theme: ThemeData(fontFamily: 'Varela'),
    );
  }
}