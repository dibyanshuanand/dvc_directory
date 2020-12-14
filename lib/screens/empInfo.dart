import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dvcdirectory/models/color.dart';
import 'package:dvcdirectory/utils/database_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:dvcdirectory/models/employee.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeInfo extends StatefulWidget {
  final String name, desig;

  EmployeeInfo(this.name, this.desig);

  @override
  _EmployeeInfoState createState() => _EmployeeInfoState();
}

class _EmployeeInfoState extends State<EmployeeInfo> {
  bool _desigExists = true;
  bool _locDifferent = false;

  /*Future<List<Map<String, dynamic>>> getDb() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, "work_database.db");
    Database db = await openDatabase(path);

    var result = await db.rawQuery('''SELECT * FROM dvc_contact WHERE name="${widget.name}" AND designation="${widget.desig}"''');

    return result;
  }*/

  _callNumber(String number) async{
    String url = 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch: $url';
    }
  }

  _sendEmail(String mail) async{
    String url = 'mailto:$mail';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch: $url';
    }
  }

  Widget _infoCard(BuildContext context, List<Map<String, dynamic>> list) {
    double containerWidth = MediaQuery.of(context).size.width;
    if (Employee.fromMap(list[0]).location != Employee.fromMap(list[0]).field)
      _locDifferent = true;


    return Center(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: MyColors.cardColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          width: containerWidth - 25,
          height: 275,
          child: Stack(
            children: [
              Container(
                width: containerWidth - 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Image.asset("assets/dvc_logo_card.png",
                          height: 50, width: 50),
                        SizedBox(width: 75),
                        _locDifferent ? Text(
                          "${Employee.fromMap(list[0]).location}",
                          style: TextStyle(fontSize: 15),
                        ) : SizedBox(width: 1),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            "${Employee.fromMap(list[0]).name ?? ''}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 22),
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(width: 5),
                        Text(
                          "${Employee.fromMap(list[0]).designation ?? ''}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(width: 5),
                        Wrap(
                          children: [
                            Image.asset("assets/telephone_icon.png",
                              height: 25, width: 25,),
                            SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                if (Employee
                                    .fromMap(list[0])
                                    .contactOff != null) {
                                  try {
                                    _callNumber(Employee
                                        .fromMap(list[0])
                                        .contactOff);
                                  } catch (e) {
                                    print('Exception: $e');
                                  }
                                }
                              },
                              child: Text(
                                "${Employee
                                    .fromMap(list[0])
                                    .contactOff ?? '~'}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(width: 5),
                        Wrap(
                          children: [
                            Image.asset("assets/mob_icon.png",
                              height: 25, width: 25,),
                            SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                if (Employee
                                    .fromMap(list[0])
                                    .contactMob != null) {
                                  try {
                                    _callNumber(Employee
                                        .fromMap(list[0])
                                        .contactMob);
                                  } catch (e) {
                                    print('Exception: $e');
                                  }
                                }
                              },
                              child: Text(
                                "${Employee
                                    .fromMap(list[0])
                                    .contactMob ?? '~'}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(width: 5),
                        Wrap(
                          children: [
                            Image.asset("assets/email_icon.png",
                              height: 25, width: 25,),
                            SizedBox(width: 12),
                            InkWell(
                                onTap: () {
                                  if (Employee.fromMap(list[0]).email != null) {
                                    try {
                                      _sendEmail(Employee.fromMap(list[0])
                                          .email);
                                    } catch(e) {
                                      print('Exception: $e');
                                    }
                                  }
                                },
                              child: Text(
                                "${Employee.fromMap(list[0]).email ?? '~'}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 17),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
}

  @override
  Widget build(BuildContext context) {
    String queryToSend;
    if (widget.desig == null)
      _desigExists = false;
    if (_desigExists)
      queryToSend = '''SELECT * FROM dvc_contact WHERE name="${widget.name}" AND designation="${widget.desig}"''';
    else
      queryToSend = '''SELECT * FROM dvc_contact WHERE name="${widget.name}"''';

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Info',
            style: TextStyle(color: MyColors.primaryColor)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: MyColors.primaryColor),
      ),
      body: SafeArea(
        child: Center(
            child: FutureBuilder(
              future: DatabaseHelper.initializeDatabase(queryToSend),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _infoCard(context, snapshot.data);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
        ),
      ),
    );
  }
}