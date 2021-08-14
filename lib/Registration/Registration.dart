
import 'package:Easy_Shopping/Registration/RegisterForm.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
       appBar: AppBar(
        backgroundColor: appColor,
        automaticallyImplyLeading: false,
        leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.close),
      onPressed: (){
        Navigator.pop(context);
      },
      );
    },
  ),
        title: Text("Registration",
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(

            child: Column(
              children: <Widget>[
                RegisterForm()
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}