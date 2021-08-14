import 'dart:convert';

import 'package:Easy_Shopping/Navigation/Navigation.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/api/api.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomFeedbackScreen extends StatefulWidget {
  @override
  _CustomFeedbackScreenState createState() => _CustomFeedbackScreenState();
}

class _CustomFeedbackScreenState extends State<CustomFeedbackScreen> {

 TextEditingController msgController = new TextEditingController();
 bool _isLoading = false;
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
        title: Text("Custom Message"),
        titleSpacing: 0,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Container(
         child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  //width: 300,
                  height: 30,
                  margin: EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    "Message",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color(0xFF000000), fontFamily: "sourcesanspro", fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                      margin: EdgeInsets.only(bottom:20),
                      elevation: 4,
                     child: Container(
                    //color: Colors.blue,
                    //padding: EdgeInsets.all(10.0),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: new TextField(
                          controller: msgController,
                          maxLines: 7,
                          decoration: new InputDecoration(
                            focusedBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                            enabledBorder:
                                UnderlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                            hintText: 'Add your text here',
                            hintStyle: TextStyle(color: Color(0xFF9b9b9b), fontSize: 15, fontFamily: "sourcesanspro", fontWeight: FontWeight.w300),
                            fillColor: Color(0xFFFFFFFF),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 20, top: 30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                 Container(
              alignment: Alignment.centerLeft,
              //height: 90,
              width: MediaQuery.of(context).size.width,
              //color: Colors.yellow,
              child: Column(
                children: <Widget>[
                  ///////////////// Submit Button  Start///////////////

                  Container(
                      decoration: BoxDecoration(
                        color: appColor.withOpacity(0.9),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: FlatButton(
                          child: Text(
                          _isLoading?"Submitting....":"Submit",
                            
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              decoration: TextDecoration.none,
                              fontFamily: 'MyriadPro',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          color: Colors.transparent,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                          onPressed: () {
                           _isLoading?null: _send();
                            //Navigator.pop(context);
                          })),

                  ///////////////// Submit Button  End///////////////
                ],
              ),
            )
              ],
            ),
          ),
        ),
      ),
    );
  }

   _send() async {
    if (msgController.text.isEmpty) {
         Fluttertoast.showToast(
          msg: "Message is empty",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appColor.withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 13.0);
    } 
    else{

    setState(() {
      _isLoading = true;
    });

    var data = {

      'userId': userData['id'],
      'message': msgController.text,
    };

    var res = await CallApi().postData(data,'/api/addSuggestion');
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
   }

   _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(msg,),
      action: SnackBarAction(
        label: "Close",
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

}
