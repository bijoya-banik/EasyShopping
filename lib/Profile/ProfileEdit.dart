

import 'package:Easy_Shopping/Profile/ProfileEditForm.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:flutter/material.dart';



class ProfileEditDialog extends StatefulWidget {
  @override
  _ProfileEditDialogState createState() => new _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor:appColor,
        title: Text("Edit Profile"),
      ),
      //body: new Text("It's a Dialog!"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: new Container(
              padding: EdgeInsets.all(0.0),
              //color: Colors.white,
              child: ProfileEditForm()),
        ),
      ),
    );
  }
}
