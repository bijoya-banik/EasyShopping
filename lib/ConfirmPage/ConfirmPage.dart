import 'package:Easy_Shopping/Navigation/Navigation.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:flutter/material.dart';


class ConfirmPage extends StatefulWidget {
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {

  
  Future<bool> _onWillPop() async {
 
                bottomNavIndex = 0;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Navigation()));

             
   }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(

       backgroundColor: appColor,
        body: 
          Stack(
            children: <Widget>[
           

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
        decoration: BoxDecoration(
                    
                      
                      // colorFilter: new ColorFilter.mode(
                      //     Colors.black.withOpacity(0.5), BlendMode.dstATop),
                    ),
                    child: Image.asset("assets/images/icons8_ok.png",
                    color:Colors.white,
                    height: 80,
                    width: 80,
                    fit: BoxFit.fill,
                    ),
                     
        ),
                  ),

                  SizedBox(height:10),
                  Container(
                   // color:appColor,
                    child: Text(
                                'Order Confirmed',
                                style: TextStyle(
                               
                               
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                )
                    )
                  ),

                  SizedBox(height:20),
RaisedButton(
  padding: EdgeInsets.only(left:20, right:20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: appColor)),
      onPressed: () {
          bottomNavIndex = 0;
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Navigation()));

      },
      color:Colors.white.withOpacity(0.85),
      textColor: appColor,
      child: Text("Back to Home".toUpperCase(),
        style: TextStyle(fontSize: 14)),
    ),
                ],
              ),


        
            ],
          ),
        
      ),
    );
  }
}