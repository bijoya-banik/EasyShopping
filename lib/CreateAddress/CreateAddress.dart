import 'dart:convert';
import 'package:Easy_Shopping/LocationMap/LocationMap.dart';
import 'package:Easy_Shopping/LocationMap/MapPage.dart';
import 'package:Easy_Shopping/ShowAddress/ShowAddress.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;


class CreateAddress extends StatefulWidget {
  final address;
  final id;
  CreateAddress(this.address, this.id);
  @override
  _CreateAddressState createState() => _CreateAddressState();
}

class _CreateAddressState extends State<CreateAddress> {
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

  TextEditingController titleEditingController=TextEditingController();
  TextEditingController houseEditingController=TextEditingController();
  TextEditingController streetEditingController=TextEditingController();
  TextEditingController areaEditingController=TextEditingController();
  TextEditingController blockEditingController=TextEditingController();
  TextEditingController floorEditingController=TextEditingController();


  String allPlacesName = "";
  var allPlacesId = "";
  var allPlaceCharge ="";
  bool isLoading = false;
  bool _isLocation = false;
  String hintName="Choose Location";
   bool _address = false;
   bool _isCreate = false;
   String id="";
  //var locationData;
  var body;
  @override
  void initState() {
  // this._loadData();
  visit = "add";
    super.initState();
   

    
  }



    
Future<bool> _onWillPop() async {

      //Navigator.push( context, SlideLeftRoute(page: AddressSystem()));
                
   }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appColor,
          title: Text('Create Address'),
           
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                // Navigator.push(
                // context,
                // MaterialPageRoute(builder: (context) => ShowAddress()),
              //);
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
                              margin: EdgeInsets.only(top:15),
                              height: 50,
                              width: double.infinity,
                              child: RaisedButton(
                                color:appColor,
                                onPressed: () {

                                
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         //builder: (context) => MapPage("","","","","")));
                                  //         builder: (context) => MapPage()));
                                },
                                textColor: Colors.white,
                                child: const Text('Pick your Location',
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ),
                                    Container(
                                        margin: EdgeInsets.only(top:20, bottom:10),
                                        child: Text(
                                          "Or",
                                          style: TextStyle(
                                              color: black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ))
                                    
               

                        ],
                      ),
                  
Container(
                                        margin: EdgeInsets.only(top:10, bottom:10),
                                        child: Text(
                                          "Enter your address details",
                                          style: TextStyle(
                                              color: appColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        )),
                 

                                
                                   Column(
                    children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        controller: titleEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            color: appColor,
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
                            color: appColor,
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
                            color: appColor,
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
                    //         color: appColor,
                    //         fontSize: 14.0,
                    //       ),
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.black54),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                   
                  ]),
               //  !_isCreate?Container(): 
                  Container(
                      padding: EdgeInsets.only(top: 15, right: 5, bottom: 5),
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        onPressed: () {
                          //_addAddress();
                        },
                        color: isLoading?Colors.grey:appColor,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            isLoading?"Saving...":'Create',
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

//     void _addAddress() async {

//    if(locationId=="1" && streetEditingController.text.isEmpty){

   
//        _showMsg("Road name is empty");
    
//    }

//     else if(locationId=="2" && streetEditingController.text.isEmpty){

   
//        _showMsg("Select an area");
    
//    }

//    else{
//      if (this.mounted){
//     setState(() {
//         isLoading = true;
//     });
//      }

//     print("data");

//        var response = await http
//         .post("https://admin.duare.net/api/address_add.php", body: {
//         "house": houseEditingController.text,
//         "road":streetEditingController.text,
//         "area": locationName,
//         "id": id,
//         "title":titleEditingController.text
//     });
//     print(response.statusCode);
//     if(response.statusCode==200){

//        Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => AddressSystem()));

//     }

//     else{
//       _showMsg("Something went wrong.Try again");
//     }
//   //  var res = json.decode(response.body); 
      
//   //     print(res);
// if (this.mounted){

//     setState(() {
//         isLoading = false;
//     });

//    }
//    }


   



//   }
}
