import 'dart:async';
import 'package:flutter/material.dart';

class ImageRotater extends StatefulWidget {
  final List<String> photos;

  ImageRotater(this.photos);

  @override
  State<StatefulWidget> createState() => new ImageRotaterState();
}

class ImageRotaterState extends State<ImageRotater> {
  int _pos = 0;
  Timer _timer;

  @override
  void initState() {
    _timer = Timer(new Duration(seconds: 2), () {
      setState(() {
        _pos = (_pos + 1) % widget.photos.length;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Image.asset(
      widget.photos[_pos],
      gaplessPlayback: true,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    super.dispose();
  }
}