import 'package:dvcdirectory/models/employee.dart';
import 'package:dvcdirectory/screens/empInfo.dart';
import 'package:flutter/material.dart';
import 'package:dvcdirectory/models/color.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:dvcdirectory/utils/database_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchEmpList extends StatefulWidget {
  final String nameSearch;

  SearchEmpList(this.nameSearch);

  @override
  _EmpListState createState() => _EmpListState();
}

class _EmpListState extends State<SearchEmpList> {

  Widget _emptySearchView(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: _screenHeight*0.15,
            ),
            child: Image.asset("assets/no_results.jpg"),
          ),
          SizedBox(height: 20),
          Text("No matching results \nfound",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35, fontFamily: 'MarckScript'),
          ),
        ],
      ),
    );
  }

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
                  subtitle: Text('${Employee.fromMap(list[index]).designation
                      ?? ''}'),
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

    var result = await db.rawQuery('''SELECT name, designation FROM dvc_contact 
                                      WHERE field="$loc"''');

    return result;
  }

  @override
  Widget build(BuildContext context) {
    String queryToSend = '''SELECT name, designation FROM dvc_contact 
                            WHERE name like "%${widget.nameSearch}%"''';

    return Scaffold(
        appBar: AppBar(
          title: Text('Search Results',
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
                      List<Map<String, dynamic>> list = result;
                      if (list.length == 0)
                        return _emptySearchView(context);
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