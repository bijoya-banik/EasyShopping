import 'dart:convert';
import 'package:Easy_Shopping/DeliveredOrderList/DeliveredOrderList.dart';
import 'package:Easy_Shopping/Login/Login.dart';
import 'package:Easy_Shopping/Logout/Logout.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/Profile/QueryFeedback.dart';
import 'package:Easy_Shopping/Profile/CustomFeedback.dart';
import 'package:Easy_Shopping/ShowAddress/ShowAddress.dart';
import 'package:Easy_Shopping/SliderButton.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:Easy_Shopping/redux/action.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  var userData;
  bool _isLoggedIn = false;

  @override
  void initState() {
   
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appColor,
          automaticallyImplyLeading: true,
          titleSpacing: 0,
          centerTitle: true,
          title: Center(
            child: Container(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Feedback",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: new Container(
              padding: EdgeInsets.all(0.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  // Container(
                  //   margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: <Widget>[
                  //       Container(
                  //         //transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                  //         padding: EdgeInsets.all(1.0),
                  //         child: CircleAvatar(
                  //           radius: 30.0,
                  //           backgroundColor: Colors.transparent,
                  //           backgroundImage:
                  //               AssetImage('assets/images/camera.png'),
                  //         ),
                  //         decoration: new BoxDecoration(
                  //           color: Colors.grey, // border color
                  //           shape: BoxShape.circle,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           Text(
                  //             "Hello,",
                  //             style: TextStyle(
                  //                 fontSize: 13, color: Colors.black38),
                  //           ),
                  //           Row(
                  //             children: <Widget>[
                  //               Text(
                  //                 userData != null
                  //                     ? '${userData['firstName']}'
                  //                     : '',
                  //                 style: TextStyle(fontSize: 17),
                  //               ),
                  //               SizedBox(width: 3),
                  //               Text(
                  //                 userData != null
                  //                     ? '${userData['lastName']}'
                  //                     : '',
                  //                 style: TextStyle(fontSize: 17),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //     margin: EdgeInsets.only(top: 20),
                  //     height: 2,
                  //     child: Divider()),
                  Expanded(
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                        
                          GestureDetector(
                            onTap: () {
                             
                                Navigator.push(context,
                                    SlideLeftRoute(page: QueryFeedbackScreen()));
                             
                            },
                            child: ListTile(
                              title: Container(
                                  child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.bookmark_border,
                                    color: Colors.black54,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text(
                                     "Feedback",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ],
                              )),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          ),

                              Divider(height: 0),
                          GestureDetector(
                            onTap: () {
                             
                                Navigator.push(context,
                                    SlideLeftRoute(page: CustomFeedbackScreen()));
                             
                            },
                            child: ListTile(
                              title: Container(
                                  child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.bookmark_border,
                                    color: Colors.black54,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text(
                                     "Custom Message",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ],
                              )),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          ),


                        
                        

                         
                          // ListTile(
                          //   title: Center(
                          //       child: Container(
                          //     margin: EdgeInsets.only(
                          //         left: 40, right: 40, top: 50),
                          //     child: SliderButton(
                          //       action: () {


                          //          Navigator.push(context, SlideLeftRoute(page: Login()));
                          //         _logout();
                          //       },
                          //       label: Text(
                          //        "Slide left to logout",
                          //         style: TextStyle(
                          //             color: Color(0xff4a4a4a),
                          //             fontWeight: FontWeight.w500,
                          //             fontSize: 17),
                          //       ),
                          //       icon: Padding(
                          //         padding: const EdgeInsets.all(13.0),
                          //         child: Icon(
                          //           Icons.touch_app,
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //     ),
                          //   )),
                          //   //trailing: Icon(Icons.chevron_right),
                          // )
                           

                          ///////////////// logout Button  Start///////////////
                          // Center(
                          //     child: Container(
                          //   margin:
                          //       EdgeInsets.only(left: 40, right: 40, top: 50),
                          //   child: SliderButton(
                          //     action: () {
                          //       _logout();
                          //     },
                          //     label: Text(
                          //       "Slide left to logout",
                          //       style: TextStyle(
                          //           color: Color(0xff4a4a4a),
                          //           fontWeight: FontWeight.w500,
                          //           fontSize: 17),
                          //     ),
                          //     icon: Padding(
                          //       padding: const EdgeInsets.all(13.0),
                          //       child: Icon(
                          //         Icons.touch_app,
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ))
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
 
_logout() async{

 


    Navigator.push(context, SlideLeftRoute(page: Logout()));
}


  // _showToast() {
  //   Fluttertoast.showToast(
  //       msg: FlutterI18n.translate(context, "You_are_logged_out")+"!" ,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIos: 1,
  //       backgroundColor: appTealColor.withOpacity(0.9),
  //       textColor: Colors.white,
  //       fontSize: 13.0);
  // }
}
