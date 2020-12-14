import 'package:dvcdirectory/models/employee.dart';
import 'package:dvcdirectory/screens/empInfo.dart';
import 'package:flutter/material.dart';
import 'package:dvcdirectory/models/color.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:dvcdirectory/utils/database_helper.dart';

class EmpList extends StatefulWidget {
  final String location;

  EmpList(this.location);

  @override
  _EmpListState createState() => _EmpListState();
}

class _EmpListState extends State<EmpList> {

  Widget _myListView(BuildContext context, List<Map<String, dynamic>> list) {
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4.0,
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 6.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE3F2FD),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: ListTile(
                  title: Text('${Employee.fromMap(list[index]).name}',),
                  subtitle: Text('${Employee.fromMap(list[index]).designation ?? ''}'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EmployeeInfo(
                                Employee.fromMap(list[index]).name,
                                Employee.fromMap(list[index]).designation,
                              ),
                        ),
                    );
                  },
                ),
              ),
            );
          },
          itemCount: list.length
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getDb(String loc) async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, "work_database.db");
    Database db = await openDatabase(path);

    var result = await db.rawQuery('''SELECT name, designation FROM dvc_contact WHERE field="$loc"''');

    return result;
  }

  @override
  Widget build(BuildContext context) {
    String queryToSend = '''SELECT name, designation FROM dvc_contact 
                            WHERE field="${widget.location}"''';

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.location}',
            style: TextStyle(color: MyColors.primaryColor)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: MyColors.primaryColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: FutureBuilder(
              future: DatabaseHelper.initializeDatabase(queryToSend),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var result = snapshot.data;
                  return _myListView(context, result);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            )
          ),
        ),
      )
    );
  }
}