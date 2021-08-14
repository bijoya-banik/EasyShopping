import 'dart:convert';
import 'package:Easy_Shopping/ChangePassword/ChangePassword.dart';
import 'package:Easy_Shopping/Navigation/Navigation.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/Profile/ProfileEdit.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileViewPage extends StatefulWidget {
  @override
  _ProfileViewPageState createState() => new _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  String result = '';
  var userData;

  @override
  void initState() {
   _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    if (userJson != null) {
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
    }
  }

  Container profileInfo(Icon icon, String label, String data) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            icon,
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                    label,
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 8, top: 3),
                      child: Text(
                        data,
                        style: TextStyle(color: Colors.black38, fontSize: 15),
                      ))
                ],
              ),
            ),
          ],
        ));
  }


  

  Future<bool> _onWillPop() async {
    bottomNavIndex = 3;
    Navigator.push(context, SlideLeftRoute(page: Navigation()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        //backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: appColor,
          leading: GestureDetector(
            onTap: () {
            
              Navigator.push(context, SlideLeftRoute(page: Navigation()));
            },
            child: Container(
                padding: EdgeInsets.all(15),
                child: Icon(Icons.arrow_back, color: Colors.white)),
          ),
          title: Center(
            child: Container(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Profile",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    GestureDetector(
                        onTap: () {
                          editProfile();
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            child: Icon(Icons.edit)))
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, SlideLeftRoute(page: ChangePassword()));
                },
                child: Container(
                    padding: EdgeInsets.only(right: 13),
                    child: Icon(Icons.vpn_key)))
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: new Container(
                padding: EdgeInsets.all(0.0),
                child: Column(
                  children: <Widget>[
                    ///////////  profile name and picture start ///////////

                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ///////////  profile  picture start ///////////
                          Container(
                            padding: EdgeInsets.all(1.0),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage: userData == null
                                  ? AssetImage('assets/images/profile.png')
                                  : userData['profilepic'] == null ||
                                          userData['profilepic'] == ''
                                      ? AssetImage('assets/images/profile.png')
                                      : NetworkImage(
                                          '${userData['profilepic']}'),
                            ),
                            decoration: new BoxDecoration(
                              color: Colors.grey, // border color
                              shape: BoxShape.circle,
                            ),
                          ),

                          ///////////  profile picture end /////////Profil//
                          SizedBox(
                            width: 10,
                          ),

                          ///////////  profile name start ///////////
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Hello"+",",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black38),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    userData != null
                                        ? '${userData['firstName']}'
                                        : '',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SizedBox(width: 2.0),
                                  Text(
                                    userData != null
                                        ? '${userData['lastName']}'
                                        : '',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          ///////////  profile name end ///////////
                        ],
                      ),
                    ),

                    ///////////  profile name and picture end ///////////

                    Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 2,
                        child: Divider()),

                    ///////////  Email ///////////

                    profileInfo(
                        Icon(
                          Icons.mail,
                          color: Colors.grey,
                        ),
                        "Email",
                        userData != null
                            ? userData['email'] != null
                                ? '${userData['email']}'
                                : 'Email'
                            : 'Email'),
                    profileInfo(
                        Icon( 
                          Icons.mail,
                          color: Colors.grey,
                        ),
                        "Mobile",
                        userData != null
                            ? userData['phone'] != null
                                ? '${userData['phone']}'
                                : 'Mobile'
                            : 'Mobile'),

                
                    // Container(
                    //     margin: EdgeInsets.only(top: 0),
                    //     height: 2,
                    //     child: Divider()),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  void editProfile() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new ProfileEditDialog();
        },
        fullscreenDialog: true));
  }
}
