import 'dart:convert';

import 'package:Easy_Shopping/Navigation/Navigation.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/api/api.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QueryFeedbackScreen extends StatefulWidget {
  @override
  _QueryFeedbackScreenState createState() => _QueryFeedbackScreenState();
}

class _QueryFeedbackScreenState extends State<QueryFeedbackScreen> {

 TextEditingController msgController = new TextEditingController();
 bool _isLoading = false;
 bool location = true;
 bool file = true;
 bool bank = true;
 bool contact = true;
  String locationString = "";
 String fileString = "";
 String bankString = "";
 String contactString = "";
 var userData;

 @override
  void initState() {
   _getUserInfo();
    super.initState();
  }

  
  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text("Feedback"),
        titleSpacing: 0,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
         child: Column(
           children: [


             /////////////// location////////////
             Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Container(
                       margin:EdgeInsets.only( top:5, bottom: 10),
                       child: Text(
                                           "Do you want to share your location for further use?",
                                            style: TextStyle(color: Colors.black,
                                            fontSize: 17),
                                          ),
                     ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        

                         Container(
                            margin: EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              if (!mounted) return;
                              setState(() {
                                 location = true;
                                  print(location);
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(1),
                                  child:location
                                      ? Icon(
                                          Icons.radio_button_checked,
                                          color: appColor,
                                        )
                                      : Icon(Icons.radio_button_off_outlined, color: Colors.grey),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 20, left: 5, top: 0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Yes",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Oswald', fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                         Container(
                            margin: EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              if (!mounted) return;
                              setState(() {
                                location = false;
                                print(location);
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(1),
                                  child:!location
                                      ? Icon(
                                          Icons.radio_button_checked,
                                          color: appColor,
                                        )
                                      : Icon(Icons.radio_button_off_outlined, color: Colors.grey),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 20, left: 5, top: 0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "No",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Oswald', fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),
 Divider(height:2, color: Colors.grey,),
              //////////////// file ////////////////
                Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Container(
                       margin:EdgeInsets.only( top:5, bottom: 10),
                       child: Text(
                                           "Are you okay to share your file manager with this app for better user experience?",
                                            style: TextStyle(color: Colors.black,
                                            fontSize: 17),
                                          ),
                     ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        

                         Container(
                            margin: EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              if (!mounted) return;
                              setState(() {
                                 file = true;
                                  print(file);
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(1),
                                  child:file
                                      ? Icon(
                                          Icons.radio_button_checked,
                                          color: appColor,
                                        )
                                      : Icon(Icons.radio_button_off_outlined, color: Colors.grey),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 20, left: 5, top: 0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Yes",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Oswald', fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                         Container(
                            margin: EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              if (!mounted) return;
                              setState(() {
                                file = false;
                                print(file);
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(1),
                                  child:!file
                                      ? Icon(
                                          Icons.radio_button_checked,
                                          color: appColor,
                                        )
                                      : Icon(Icons.radio_button_off_outlined, color: Colors.grey),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 20, left: 5, top: 0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "No",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Oswald', fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),
              Divider(height:2, color: Colors.grey,),

               /////////////// bank details////////////
             Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Container(
                       margin:EdgeInsets.only( top:5, bottom: 10),
                       child: Text(
                                           "Do you want to save your bank details for further transaction?",
                                            style: TextStyle(color: Colors.black,
                                            fontSize: 17),
                                          ),
                     ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        

                         Container(
                            margin: EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              if (!mounted) return;
                              setState(() {
                                 bank = true;
                                  print(bank);
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(1),
                                  child:bank
                                      ? Icon(
                                          Icons.radio_button_checked,
                                          color: appColor,
                                        )
                                      : Icon(Icons.radio_button_off_outlined, color: Colors.grey),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 20, left: 5, top: 0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Yes",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Oswald', fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                         Container(
                            margin: EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              if (!mounted) return;
                              setState(() {
                                bank = false;
                                print(bank);
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(1),
                                  child:!bank
                                      ? Icon(
                                          Icons.radio_button_checked,
                                          color: appColor,
                                        )
                                      : Icon(Icons.radio_button_off_outlined, color: Colors.grey),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 20, left: 5, top: 0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "No",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Oswald', fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),
 Divider(height:2, color: Colors.grey,),
              //////////////// Contact ////////////////
                Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Container(
                       margin:EdgeInsets.only( top:5, bottom: 10),
                       child: Text(
                                           "Do you want to save your contact details for further use?",
                                            style: TextStyle(color: Colors.black,
                                            fontSize: 17),
                                          ),
                     ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        

                         Container(
                            margin: EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              if (!mounted) return;
                              setState(() {
                                 contact = true;
                                  print(contact);
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(1),
                                  child:contact
                                      ? Icon(
                                          Icons.radio_button_checked,
                                          color: appColor,
                                        )
                                      : Icon(Icons.radio_button_off_outlined, color: Colors.grey),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 20, left: 5, top: 0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Yes",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Oswald', fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                         Container(
                            margin: EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              if (!mounted) return;
                              setState(() {
                                contact = false;
                                print(contact);
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(1),
                                  child:!contact
                                      ? Icon(
                                          Icons.radio_button_checked,
                                          color: appColor,
                                        )
                                      : Icon(Icons.radio_button_off_outlined, color: Colors.grey),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 20, left: 5, top: 0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "No",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Oswald', fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),


                   ////////////////////  Button Start  ////////////////
          
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                         
                         _isLoading?null: _send();
                       
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 20, bottom: 0),
                          decoration: BoxDecoration(
                              color: appColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                           _isLoading?"Please wait...": "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'BebasNeue',
                            ),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                ],
              ),
            ),


               ////////////////////  Button End  ////////////////
           ],
         ),
        ),
      ),
    );
  }

   _send() async {
    
 if(location==true){
   locationString = "Yes";
 }
 else{
   locationString = "No";
 }
 if(file==true){
   fileString = "Yes";
 }
 else{
   fileString = "No";
 }
 if(bank==true){
   bankString = "Yes";
 }
 else{
   bankString = "No";
 }
 if(contact==true){
   contactString = "Yes";
 }
 else{
   contactString = "No";
 }

    setState(() {
      _isLoading = true;
    });

    var data = {

      'userId': userData['id'],
      'location': locationString,
      'file': fileString,
      'bank_details': bankString,
      'contact_details': contactString,
    };

    var res = await CallApi().postData(data,'/api/addFeed');
    var body = json.decode(res.body);
    print(body);
    if (res.statusCode==200) {
      bottomNavIndex = 0;
       Navigator.push(context,
                                    SlideLeftRoute(page: Navigation()));
   Fluttertoast.showToast(
          msg: "Submitted Succesfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appColor.withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 13.0);

    } else {
       Fluttertoast.showToast(
          msg: "Something went wrong!! Try again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appColor.withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 13.0);
    }

     setState(() {
      _isLoading = false;
    });
  
   }

   _showMsg(msg) {
 Fluttertoast.showToast(
          msg: "Message is empty",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appColor.withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 13.0);
  }

}
