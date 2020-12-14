import 'package:dvcdirectory/screens/empList.dart';
import 'package:flutter/material.dart';
import '../models/location.dart';
import '../models/color.dart';

class ListScreen extends StatefulWidget {

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Location> firstList = [
    new Location('DVC HQ'),
    new Location('MAITHON'),
  ];
  List<Location> secondList = [
    new Location('BTPS'), new Location('CTPS'), new Location('DSTPS'),
    new Location('DTPS'), new Location('KTPS'), new Location('MTPS'),
    new Location('RTPS'), new Location('Maithon Hydel Station'),
    new Location('Panchet Hydel Station'),
    new Location('Tilayia Hydel Station'),
  ];
  List<Location> thirdList = [
    Location('ASP S/s'), Location('Barhi S/s'), Location('Barjora S/s'),
    Location('Belmuri S/s'), Location('Biada S/s'), Location('Burdwan S/s'),
    Location('Burnpur S/s'), Location('Chandil S/s'), Location('Dhanbad S/s'),
    Location('Giridih S/s'), Location('Gola S/s'),
    Location('Hazaribagh Project'), Location('Hazaribagh S/s'),
    Location('Howrah S/s'), Location('Jamshedpur S/s'), Location('Jamuria S/s'),
    Location('KTPS 220 KV S/s'), Location('Kalipahari S/s'),
    Location('Kalyaneswari S/s'), Location('Kharagpur S/s'),
    Location('Koderma 132 KV S/s'), Location('Kolaghat S/s'), Location('Konar S/s'),
    Location('Kumardhubi S/s'), Location('Luchipur S/s'), Location('Mosabani S/s'),
    Location('Muchipara S/s'), Location('Nimiaghat S/s'),
    Location('North Karanpura S/s'), Location('Parulia S/s'),
    Location('Patherdih S/s'), Location('Patratu S/s'), Location('Purulia S/s'),
    Location('Putki S/s'), Location('Ramgarh S/s'), Location('Ramkanali S/s'),
    Location('Ranchi S/s'), Location('Right Bank S/s'), Location('Shibpur S/s'),
    Location('Sindri S/s'), Location('Bermo Mines'), Location('New Delhi Office'),
    Location('REP'), Location('Personal Notings'),
  ];

  Widget _myListView(BuildContext context, List<Location> list) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Color(0xFFE3F2FD)),
              child: ListTile(
                title: Text(list[index].name),
                contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 25),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => EmpList(list[index].name)
                  ));
                },
              ),
            ),
          );
        },
        itemCount: list.length
      ),
    );
  }

  Widget _myCard(BuildContext context, List<Location> secList, int position) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EmpList(secList[position].name)
            )
        );
      },
      child: Container(
        child: Text(secList[position].name),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose station',
          style: TextStyle(color: MyColors.primaryColor)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: MyColors.primaryColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _myListView(context, firstList),
            Container(
              width: MediaQuery.of(context).size.width,
              color: MyColors.primaryColor,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                'POWER HOUSES',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            _myListView(context, secondList),
            Container(
              width: MediaQuery.of(context).size.width,
              color: MyColors.primaryColor,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                'SUB-STATIONS / OT-OFFICES',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Wrap(
              children: <Widget>[
                _myListView(context, thirdList),
              ],
            ),
          ],
        ),
      ),
    );
  }
}