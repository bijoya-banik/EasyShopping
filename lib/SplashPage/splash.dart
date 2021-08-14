
import 'package:Easy_Shopping/Login/Login.dart';
import 'package:Easy_Shopping/Navigation/Navigation.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  bool _isLoggedIn = false;
  var userData;

  @override
  void initState() {
    super.initState();

    loadData();
    
  }


  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    if (token != null) {
   
        _isLoggedIn = true;
    
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => _isLoggedIn ? Navigation() : Login()));
      //  builder: (context) =>  Login()));
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          // border: Border.all(color: Colors.white, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: EdgeInsets.only(bottom:5),
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFFda1f25),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  
                    child: logo),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      dotIndicator(),
                      dotIndicator(),
                      dotIndicator(),
                      dotIndicator(),
                      dotIndicator(),
                    ],
                  ),
                ),

               
              ],
            ),
          ),
        ),

      ),
    );
  }

  Container dotIndicator() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Shimmer.fromColors(
        baseColor: appColor,
        highlightColor: appColor.withOpacity(0.5),
        child: CircleAvatar(
          radius: 5.0,
        ),
      ),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
      ),
    );
  }

 
}
