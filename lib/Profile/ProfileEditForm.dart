import 'dart:convert';
import 'dart:io';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/Profile/ProfileView.dart';
import 'package:Easy_Shopping/api/api.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum PhotoCrop {
  free,
  picked,
  cropped,
}

class ProfileEditForm extends StatefulWidget {
  @override
  _ProfileEditFormState createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  String result = '', date = 'Select Birth Date';
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController houseController = new TextEditingController();
  TextEditingController streetController = new TextEditingController();
  TextEditingController roadController = new TextEditingController();
  TextEditingController blockController = new TextEditingController();
  TextEditingController areaController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();

  var dd, finalDate;
  DateTime _date = DateTime.now();
  int gen = 1, gen1 = 0;
  Future<File> fileImage;

  ////////// Image Picker//////
  PhotoCrop state;
  File imageFile;
  String image, countryName = "", realImage = "";
  var imagePath;
  bool _isImage = false;
  bool _isLoading = false;
  List contList = [];

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



  @override
  void initState() {
    _getUserInfo();

    super.initState();
  }

  var userData, usertoken;

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    if (userJson != null) {
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
      print(userData);
      var token = localStorage.getString('token');
      setState(() {
        usertoken = token;
      });
      firstNameController.text =
          userData != null && userData['firstName'] != null
              ? '${userData['firstName']}'
              : '';
      lastNameController.text = userData != null && userData['lastName'] != null
          ? '${userData['lastName']}'
          : '';
     
    }


  }


 

  Container editinfo(String label, String hint, TextEditingController control,
      TextInputType type) {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
        child: Container(
            margin: EdgeInsets.only(left: 8, top: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.grey[100],
            ),
            child: TextField(
              cursorColor: Colors.grey,
              controller: control,
              keyboardType: type,
              autofocus: false,
              style: TextStyle(color: Colors.black54),
              decoration: InputDecoration(
                hintText: hint,
                labelText: label,
                labelStyle: TextStyle(color: appColor),
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 15.0),
                border: InputBorder.none,
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          //////////////// Picture Button Start/////////////////

          // Container(
          //     margin: EdgeInsets.only(top: 25),
          //     //color: Colors.red,
          //     child: _profilePictureButton()),
          //////////////// Picture Button End/////////////////

          /////////////////   profile first name start ///////////////
          Container(
              margin: EdgeInsets.only(top: 20), height: 2,),

          editinfo('First Name', '', firstNameController, TextInputType.text),

          /////////////////   profile last name start ///////////////
          Container(
              margin: EdgeInsets.only(top: 10,), height: 2, ),

          editinfo('Last Name', '', lastNameController, TextInputType.text),

         
          ////// country //////////
          /////////////////   profile editing save start ///////////////

          GestureDetector(
            onTap: () {
              _isLoading ? null : _updateProfile();
            },
            child: Container(
              margin: EdgeInsets.only(left: 25, right: 15, bottom: 20, top: 15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color:
                      _isLoading ? Colors.grey : appColor.withOpacity(0.9),
                  border: Border.all(width: 0.2, color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.save,
                    size: 20,
                    color: Colors.white,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(_isLoading ?"Saving..." : "Save",
                          style: TextStyle(color: Colors.white, fontSize: 17)))
                ],
              ),
            ),
          ),

          /////////////////   profile editing save end ///////////////
        ],
      ),
    );
  }

  void _updateProfile() async {
   
    var data1 = {
      "id":userData['id'],
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      
    };
    var data2 = {

      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email":userData['email'],
      "phone":userData['phone'],
      "profilePicture":userData['profilePicture'],
      "id":userData['id']
      
    };

   // print(data);

    setState(() {
      _isLoading = true;
    });
    var res =
        await CallApi().postData(data1, '/api/editUser');

    var body = json.decode(res.body);
    print(body);
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('user', json.encode(data2));
      _showMsg("Profile updated successfully");
     // Navigator.pop(context);
     // Navigator.push(context, new SlideLeftRoute(page: ProfileViewPage()));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: 
        (BuildContext context) => ProfileViewPage()));

    }  else {
       _showMsg("Something went wrong");
     
    }

    setState(() {
      _isLoading = false;
    });
  }
}

