
import 'dart:convert';

import 'package:Easy_Shopping/Login/Login.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/api/api.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  bool _isLoading = false;
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
    Scaffold.of(context).showSnackBar(snackBar);
  }

  TextEditingController registerNameController  = TextEditingController();
  TextEditingController registerLastNameController  = TextEditingController();
  TextEditingController registerEmailController  = TextEditingController();
  TextEditingController registerPhoneController  = TextEditingController();
  TextEditingController registerPasswordController  = TextEditingController();
  TextEditingController registerConfirmPasswordController  = TextEditingController();


  /////////////////////////  Register Form Design Container start///////////////////
  

    Container registerField(Icon icon, String hint, TextInputType type,bool secure,TextEditingController control) {
    return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
            margin: EdgeInsets.only(top: 13),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
                border: Border.all(width: 0.2, color: Colors.grey)),
            child: TextFormField(
               cursorColor: Colors.grey,
             controller: control,
              obscureText: secure,
              autofocus: false,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                icon: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: icon
                ),
                hintText: hint,
                hintStyle: TextStyle(fontSize: 14),
                //labelText: 'Enter E-mail',
                contentPadding: EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 5.0),
                border: InputBorder.none,
              ),
             
            ),
          );
  }
  
  
  
  /////////////////////////  Register Form Design Container end///////////////////





@override
  void initState() {

    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {

       //////////////////////////   Sign Up Form Start ///////////////
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            ////////////////////register Name  ////////////////
            registerField( Icon(
                      Icons.account_circle,
                      color: Colors.black38,
                      size: 17,
                    ),"First Name",TextInputType.text,false,registerNameController),
            ////////////////////register last  Name  ////////////////
            registerField( Icon(
                      Icons.account_circle,
                      color: Colors.black38,
                      size: 17,
                    ),"Last Name",TextInputType.text,false,registerLastNameController),
      
      
        //////////////////// register Phone ////////////////
                   
                     registerField( Icon(
                      Icons.phone,
                      color: Colors.black38,
                      size: 17,
                    ),"Phone",TextInputType.number,false,registerPhoneController),


      ////////////////////register  Email   ////////////////
                   
                     registerField( Icon(
                      Icons.mail,
                      color: Colors.black38,
                      size: 17,
                    ),"Email",TextInputType.emailAddress,false,registerEmailController),

      //////////////////// register Password  ////////////////
                   
                     registerField( Icon(
                      Icons.lock,
                      color: Colors.black38,
                      size: 17,
                    ),"Password",TextInputType.text,true,registerPasswordController),
    
    
      ////////////////////register  Confirm  Password  ////////////////
                     registerField( Icon(
                      Icons.lock,
                      color: Colors.black38,
                      size: 17,
                    ),"Confirm Password",TextInputType.text,true,registerConfirmPasswordController),
           

             //////////////////// Register Button Start  ////////////////
          
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                         
                         _isLoading?null: _registerButton();
                       
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                              left: 0, right: 0, top: 20, bottom: 0),
                          decoration: BoxDecoration(
                              color: appColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                           _isLoading?"Please wait...": "Register",
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


               //////////////////// Register Button End  ////////////////
         

               /////////////////////// Already Have Account Part Start  ////////////////
          
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  )),

                    /////////////////////// Sign in call dialouge from register Start  ////////////////
                  
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, SlideLeftRoute(page: Login()));
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: appColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )),
                  ),

                   /////////////////////// Sign in call dialouge  from register End ////////////////
                ],
              ),
            ),


              /////////////////////// Already Have Account part end  ////////////////
          ],
        ),
      ),
    );


    //////////////////////////   Sign Up Form end ///////////////
  }


      void _registerButton() async {

  String patternEmail =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExpEmail = new RegExp(patternEmail);

    if (registerNameController.text.isEmpty) {
      return _showMsg("First Name is empty");
    } 
    else if (registerLastNameController.text.isEmpty) {
      return _showMsg("Last Name is empty");
    }
    else if (registerPhoneController.text.isEmpty) {
      return _showMsg("Phone is empty");
    } 
     else if (registerPhoneController.text[0]!="0" || registerPhoneController.text[1]!="1" || registerPhoneController.text.length != 11) {
      print(registerPhoneController.text.length);
      return _showMsg("Phone number is invalid");
    }
    else if (registerEmailController.text.isEmpty) {
      return _showMsg("Email is empty");
    } 
    else if (!regExpEmail.hasMatch(registerEmailController.text)) {
      return _showMsg("Invalid Email");
    }
    else if (registerPasswordController.text.isEmpty) {
      return _showMsg("Password is empty");
    }
    else if (registerPasswordController.text.length <6) {
      return _showMsg("Password length must be more than 5");
    }
    else if (registerConfirmPasswordController.text.isEmpty) {
      return _showMsg("Confirm Password is empty");
    } 
    else if (registerConfirmPasswordController.text != registerPasswordController.text) {
      return _showMsg("Password doesn't match");
    }


    setState(() {
      _isLoading = true;
    });

    var data = {
      'firstName': registerNameController.text,
      'lastName': registerLastNameController.text,
      'email': registerEmailController.text,
      'phone': registerPhoneController.text,
      'password': registerPasswordController.text,
    
    };


    var res = await CallApi().withoutTokenPostData(data, '/api/register');
    var body = json.decode(res.body);
    print(body);
    print(res.statusCode);

      if (res.statusCode == 200) {
      
                
                  Fluttertoast.showToast(
          msg: "Registration Successful",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appColor.withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 13.0);                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
        Navigator.push(context, SlideLeftRoute(page: Login()));

      }

      else if(body['message'].contains("Duplicate entry")){
        
          _showMsg("Email already exists");
      }
      
       else {
        _showMsg("Something is wrong! Try again");
      }
  
    setState(() {
      _isLoading = false;
    });
  }


}

                                