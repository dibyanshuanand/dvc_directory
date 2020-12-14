import 'dart:async';
import 'package:dvcdirectory/models/color.dart';
import 'package:dvcdirectory/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class LogoAnimate extends StatefulWidget {

  @override
  LogoAnimateState createState() => LogoAnimateState();
}

class LogoAnimateState extends State<LogoAnimate> with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController controller;

  void navigationPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 4), vsync: this);
    animation = Tween<double>(begin: 50, end: 150)
        .animate(new CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed)
          setState(() {});
      },
      );
    controller.forward();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: <Widget>[
        Container(
          color: MyColors.backgroundColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Center(child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: animation.value,
          width: animation.value,
          child: Image.asset('assets/dvc_logo_card.png'),
        ),)
      ]),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}