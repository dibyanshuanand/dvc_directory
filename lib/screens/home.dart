import 'package:dvcdirectory/screens/listScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dvcdirectory/screens/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/color.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> photosList = [
    'assets/images/pic1.jpg',
    'assets/images/pic2.jpg',
    'assets/images/pic3.jpg',
    'assets/images/pic4.jpg',
    'assets/images/pic5.jpg',
    'assets/images/pic6.jpg',
    'assets/images/pic7.jpg',
    'assets/images/pic8.jpg',
    'assets/images/pic9.jpg',
    'assets/images/pic10.jpg',
    'assets/images/pic11.jpg',
    'assets/images/pic12.jpg',
    'assets/images/pic13.jpg',
    'assets/images/pic14.jpg',
    'assets/images/pic15.jpg',
    'assets/images/pic16.jpg',
    'assets/images/pic17.jpg',
    'assets/images/pic18.jpg',
    'assets/images/rtps1.jpg',
    'assets/images/saila.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Image.asset('assets/dvc_logo_new.jpg'),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: RaisedButton(
                    elevation: 4.0,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 30),
                      child: Text(
                        'DVC Phone Book',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    shape: StadiumBorder(),
                    color: MyColors.primaryColor,
                    textColor: Colors.white,
                    splashColor: MyColors.primaryAccentColor,
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ListScreen()));
                    },
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: RaisedButton(
                    elevation: 4.0,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 30),
                      child: Text(
                        'Search Contacts',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    shape: StadiumBorder(),
                    color: MyColors.primaryColor,
                    textColor: Colors.white,
                    splashColor: MyColors.primaryAccentColor,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchBarPage()));
                    },
                  ),
                ),
                SizedBox(height: 100),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    enlargeCenterPage: true,
                  ),
                  items: photosList.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(i, fit: BoxFit.fill),
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
