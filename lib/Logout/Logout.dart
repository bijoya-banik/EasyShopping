import 'dart:convert';
import 'package:Easy_Shopping/Login/Login.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/api/api.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:Easy_Shopping/redux/action.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogoutState();
  }
}

class LogoutState extends State<Logout> {
  bool isSubmit = true;
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
        logout();
      print(userData);
     
    }


  }
   
  Future<bool> _onWillPop() async {
    Navigator.of(context).pop();
  }
                  
  @override
  Widget build(BuildContext context) {              
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 25,
                  width: 25,        
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                    child: Text(             
                  "Logging out...",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.normal),
                )),
              ],
            ),
          ),    
        ),
      ),
    );
  }

  Future<void> logout() async {

    var data = {
      'id':userData['id']
    };

    print(data);

    var res =
        await CallApi().postData(data, '/api/logout');
    var body = json.decode(res.body);
    print(body);

    if (res.statusCode == 200) {
      
     SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('cart');
      localStorage.remove('pass');
      localStorage.remove('token');
      store.dispatch(OrderListAction([]));
      store.dispatch(TotalOrder(0));
       _showMessage("You are now logged out!", 2);

     Navigator.push( context, SlideLeftRoute(page: Login()));
                            
    } else {
      _showMessage("Something went wrong! ", 1);
     Navigator.of(context).pop();
    }
       
    setState(() {                                                                             
      isSubmit = false;
    }); 
  }                
        
  _showMessage(msg, numb) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        //timeInSecForIos: 1,
        backgroundColor: numb == 1
            ? Colors.red.withOpacity(0.9)
            : Colors.grey[600],
        textColor: Colors.white,
        fontSize: 13.0);
  }
}
