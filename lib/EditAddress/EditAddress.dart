import 'dart:convert';
import 'package:Easy_Shopping/LocationMap/LocationMap.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/ShowAddress/ShowAddress.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class EditAdress extends StatefulWidget {
  final id;
  final title;
  final house;
  final road;
  var area;

  EditAdress(this.id, this.title, this.house, this.road, this.area);
  @override
  _EditAdressState createState() => _EditAdressState();
}

class _EditAdressState extends State<EditAdress> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    //Scaffold.of(context).showSnackBar(snackBar);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController houseEditingController = TextEditingController();
  TextEditingController streetEditingController = TextEditingController();
  TextEditingController areaEditingController = TextEditingController();
  TextEditingController blockEditingController = TextEditingController();
  TextEditingController floorEditingController = TextEditingController();

  String allPlacesName = "";
  var allPlacesId = "";
  var allPlaceCharge = "";
  bool isLoading = false;
  bool _isLocation = false;
  String hintName = "Choose Location";
  String hintallPlacesName = "Choose Location";
  bool _address = false;
  bool _isCreate = false;
  String id = "";
  //var locationData;
  var body;
  @override
  void initState() {
    visit = "edit";
    // this._loadData();
    super.initState();
  
  }




  Future<bool> _onWillPop() async {
    Navigator.push(context, SlideLeftRoute(page: ShowAddress()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF081035),
          title: Text('Edit Address'),
          flexibleSpace: Image(
            image: AssetImage('images/bk.png'),
            fit: BoxFit.cover,
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowAddress()),
                );
              }),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                 

                 Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              margin: EdgeInsets.only(top: 15),
                              height: 50,
                              width: double.infinity,
                              child: RaisedButton(
                                color: Color(0xFF1741E5),
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ChooseLocation(
                                  //               widget.id,
                                  //               widget.title,
                                  //               widget.house,
                                  //               widget.road,
                                  //               widget.area,
                                  //             )));
                                },
                                textColor: Colors.white,
                                child: const Text('Select your location',
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                  
                   
Column(children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: titleEditingController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Title',
                                labelText: 'Title',
                                labelStyle: TextStyle(
                                  color: Color(0xFF1741E5),
                                  fontSize: 14.0,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: houseEditingController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'House/Plot number',
                                labelText: 'House/Plot number',
                                labelStyle: TextStyle(
                                  color: Color(0xFF1741E5),
                                  fontSize: 14.0,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: streetEditingController,
                              //  keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Street/Road',
                                labelText: 'Street/Road',
                                labelStyle: TextStyle(
                                  color: Color(0xFF1741E5),
                                  fontSize: 14.0,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                ),
                              ),
                            ),
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(5),
                          //   child: TextField(
                          //     controller: floorEditingController,
                          //     //  keyboardType: TextInputType.number,
                          //     decoration: InputDecoration(
                          //       hintText: '(Optional) Floor/Apartment Number',
                          //       labelText: 'Floor/Apartment Number',
                          //       labelStyle: TextStyle(
                          //         color: Color(0xFF1741E5),
                          //         fontSize: 14.0,
                          //       ),
                          //       focusedBorder: UnderlineInputBorder(
                          //         borderSide: BorderSide(color: Colors.black54),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ]),
                  !_isCreate
                      ? Container()
                      : Container(
                          padding:
                              EdgeInsets.only(top: 15, right: 5, bottom: 5),
                          alignment: Alignment.centerRight,
                          child: RaisedButton(
                            onPressed: () {
                              //_addAddress();
                            },
                            color: isLoading ? Colors.grey : Color(0xFF1741E5),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                isLoading ? "Saving..." : 'Edit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _addAddress() async {
  //   if (locationId == "1" && streetEditingController.text.isEmpty) {
  //     _showMsg("Road name is empty");
  //   } else if (locationId == "2" && streetEditingController.text.isEmpty) {
  //     _showMsg("Select an area");
  //   } else {
  //     if (this.mounted) {
  //       setState(() {
  //         isLoading = true;
  //       });
  //     }
  //     // print(streetEditingController.text);
  //     var response = await http
  //         .post("https://admin.duare.net/api/address_edit.php", body: {
  //       "id": widget.id,
  //       // "userId": id,
  //       "title": titleEditingController.text,
  //       "house": houseEditingController.text,
  //       "road": streetEditingController.text,
  //       "area": locationName,
  //     });
  //     // var response = await http.post(
  //     //     "https://duare.net/api/address_edit.php?id=${widget.id}&userId=${id}&title=${titleEditingController.text}&house=${houseEditingController.text}&road=${streetEditingController.text}&area=${locationName}");
  //     // print(widget.id);
  //     // print(id);

  //     print(response.body);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => AddressSystem()));
  //     } else {
  //       _showMsg("Something went wrong.Try again");
  //     }
  //     //  var res = json.decode(response.body);

  //     //     print(res);
  //     if (this.mounted) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   }
  // }
}
