import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dvcdirectory/screens/searchEmpList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dvcdirectory/models/color.dart';

class SearchBarPage extends StatefulWidget {
  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  GlobalKey _keyImage = GlobalKey();
  TextEditingController _searchBarController = TextEditingController();

  double _getImageSize() {
    final RenderBox imageRenderBox =
        _keyImage.currentContext.findRenderObject();
    final sizeImage = imageRenderBox.size;
    return sizeImage.height;
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Search', style: TextStyle(color: MyColors.primaryColor)),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: MyColors.primaryColor),
        ),
        body: Container(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD4D5F4),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _screenHeight * 0.35),
                child: Image.asset("assets/search_back.jpg"),
              ),
              Column(
                children: [
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: _searchBarController,
                      style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          color: const Color(0xFF1c1b39)),
                      decoration: InputDecoration(
                        hintText: 'Enter keyword',
                        hintStyle: TextStyle(
                            fontSize: 16,
                            letterSpacing: 0.8,
                            color: const Color(0xFF989db4)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                color: const Color(0xFF9A6AFE), width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                color: MyColors.primaryColor, width: 2)),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    splashColor: MyColors.primaryAccentColor,
                    child: RawMaterialButton(
                      onPressed: () {
                        if (_searchBarController.text.isEmpty) {
                          AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.ERROR,
                                  animType: AnimType.SCALE,
                                  title: 'Error !',
                                  desc:
                                      'Search field cannot be empty, try again',
                                  dismissOnTouchOutside: false,
                                  btnOkOnPress: () {})
                              .show();
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchEmpList(
                                      _searchBarController.text)));
                        }
                      },
                      elevation: 5.0,
                      fillColor: const Color(0xFFAD93CD),
                      padding: EdgeInsets.all(12),
                      child: Image.asset("assets/search.png",
                          height: 30, width: 30),
                      shape: CircleBorder(),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }
}
