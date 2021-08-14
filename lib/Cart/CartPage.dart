import 'dart:convert';

import 'package:Easy_Shopping/ConfirmPage/ConfirmPage.dart';
import 'package:Easy_Shopping/Navigation/Navigation.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/api/api.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {

  
TextEditingController addressController = TextEditingController();
TextEditingController phoneController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //////////// anim/////////
  AnimationController _animationController;
  AnimationController _scaleAnimationController;
  AnimationController _fadeAnimationController;

  Animation<double> _animation;
  Animation<double> _scaleAnimation;
  Animation<double> _fadeAnimation;

  double buttonWidth = 450;
  double scale = 1.0;
  bool animationComplete = false;
  double barColorOpacity = .6;
  bool animationStart = false;
  //////////// anim/////////
var house="house";
var road="road";
var area="area";

  int selectedRadio = 0;
  int chooseRadio1 = -1;
  int chooseRadio2 = -1;
  int chooseRadio3 = -1;
int nowTime = 0;
  var paymentTypeInfo = "";


bool _isLoading = false;
  _showMsg(msg) {
   
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  
  var _places = ['Sylhet', 'Others'];
  //var _marital = [];
  var _currentplaceSelected = 'Sylhet';
  void _placeSelected(String newValueSelected) {
    if (!mounted) return;
    setState(() {
      this._currentplaceSelected = newValueSelected;

      if(newValueSelected=='Sylhet'){
        shipping_cost = 30;
      }
      else{
         shipping_cost = 80;
      }
    });
  }


    var _userPhone = ['Self', 'Others'];
  var _currentuserPhoneSelected = 'Self';
  void _userPhoneSelected(String newValueSelected) {
    if (!mounted) return;
    setState(() {
      this._currentuserPhoneSelected = newValueSelected;

    });
  }
    List cartList = [];
   List cartProductList = [];
   var cartData;
   var userData;
   double subTotal = 0;
   double total = 0;
   int shipping_cost = 30;

  @override
  void initState() {

   _getUserInfo();
 getCart();
      _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));

    _scaleAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _fadeAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    _fadeAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(_fadeAnimationController);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(_scaleAnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scaleAnimationController.reverse();
          _fadeAnimationController.forward();
          _animationController.forward();
        }
      });

    _animation = Tween<double>(begin: 0.0, end: buttonWidth)
        .animate(_animationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
            if (this.mounted){
              setState(() {
                animationComplete = true;
                barColorOpacity = .0;
              });
            }
            }
          });
  
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

    getCart() async {
     SharedPreferences localStorage = await SharedPreferences.getInstance();
      var cartJson =  localStorage.getString('cart');
      if (cartJson != null) {
      var cart = json.decode(cartJson);
      //setState(() {
        cartData = cart;
        for (var d in cartData){
        setState(() {
            cartList.add(d);
        });
          cartProductList.add(d['productId']);
          print(cartList);
        }
       
    //  });
      
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text("Cart"),
         automaticallyImplyLeading: false,
         
         ),
      body: SafeArea(
          child: cartList.length==0?
                      Center(
                    child: Container(
                    child: Text("No products added to cart",),
                  )):

           SingleChildScrollView(
            physics: BouncingScrollPhysics(),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 50),
                        child: Column(
              children: [
                  ////////////   Card Start  ///////////

                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          
                              color: Colors.white,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ////////////  Cart Details Card start  ///////////

                              Container(
                                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Column(children: _cartList()),
                              ),

                              ////////////  Cart Details Card end  ///////////

                              /////////////  Subtotal  start ////////////

                              Container(
                                color: Colors.grey[350],
                                padding: EdgeInsets.only(
                                    left: 15, right: 20, top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "Subtotal",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "sourcesanspro",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                          "Tk "+subTotal.toStringAsFixed(2),
                                       
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "sourcesanspro",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              /////////////  Subtotal end ////////////

                              ///////////////shipping Cost start ////////////

                              Container(
                                padding: EdgeInsets.only(
                                    left: 15, right: 20, top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "Shipping Cost",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "sourcesanspro",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        // "\$ 657",
                                        "Tk "+shipping_cost.toStringAsFixed(2),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "sourcesanspro",
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            

                              ////////////////   Total Start   ////////////

                              Container(
                                padding: EdgeInsets.only(
                                    left: 15, right: 20, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                  top: BorderSide(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "Total",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "sourcesanspro",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                       "Tk "+total.toStringAsFixed(2),
                                        // "\$${(totalPrice).toStringAsFixed(2)}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "sourcesanspro",
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              /////////////  Total End  ////////////
                            ],
                          ),
                        ),


                        

                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.fromLTRB(15, 10, 0, 15),
                        child: Text(
                          'Delivery details',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),

                       Container(
                  //color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      

                      ////////   dropdown /////////

                      Container(
                      
                         margin: EdgeInsets.only(left:15, right:15, bottom: 8),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            bottom: 1, top: 1, left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            // border: Border.all(
                            //     color: Color(0xFFE4E4E4), width: 1.5)
                             boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300],
                                            blurRadius: 10,
                                            //offset: Offset(0.0,3.0)
                                          )
                                        ],
                                ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: Icon(Icons.keyboard_arrow_down,
                                size: 25, color: Color(0xFFC0C0C0)),
                            items: _places.map((dynamic dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xFF656565),
                                        fontSize: 16,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ));
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              _placeSelected(newValueSelected);
                            },
                            value: _currentplaceSelected,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                      ///////////////// add delivery address//
                                      Container(
                                //color: Colors.blue,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                   
                                    Container(
                                      margin: EdgeInsets.only(left:15, right:15),
                                     decoration: BoxDecoration(
                                       color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300],
                                            blurRadius: 10,
                                            //offset: Offset(0.0,3.0)
                                          )
                                        ],
                                      ),
                                      
                                     child:   Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextField(
                                              controller: addressController,
                                              maxLines: null,
                                              textInputAction: TextInputAction.newline,
                                              style: TextStyle(
                                                  color: Color(0xFF000000)),
                                              cursorColor: Color(0xFF9b9b9b),
                                              decoration: InputDecoration(
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20.0),
                                                      bottomLeft:
                                                          Radius.circular(20.0),
                                                    ),
                                                    borderSide: BorderSide(
                                                        color:Color(0xFFFFFFFF))),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20.0),
                                                        ),
                                                        borderSide: BorderSide(
                                                            color: Color(0xFFFFFFFF)),),
                                                hintText: "Type address",
                                                
                                                hintStyle: TextStyle(
                                                    color: Color(0xFF9b9b9b),
                                                    fontSize: 15,
                                                    fontFamily: "sourcesanspro",
                                                    fontWeight: FontWeight.w300),
                                                contentPadding: EdgeInsets.only(
                                                    left: 15,
                                                    bottom: 12,
                                                    right: 15,
                                                    top: 12),
                                                fillColor: Color(0xFFFFFFFF),
                                              ),
                                            ),
                                          ),
                                         
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                               Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.fromLTRB(15, 10, 0, 15),
                        child: Text(
                          'Order for',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),

                       Container(
                  //color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      

                      ////////   dropdown /////////

                      Container(
                      
                         margin: EdgeInsets.only(left:15, right:15, bottom: 8),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            bottom: 1, top: 1, left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            // border: Border.all(
                            //     color: Color(0xFFE4E4E4), width: 1.5)
                             boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300],
                                            blurRadius: 10,
                                            //offset: Offset(0.0,3.0)
                                          )
                                        ],
                                ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: Icon(Icons.keyboard_arrow_down,
                                size: 25, color: Color(0xFFC0C0C0)),
                            items: _userPhone.map((dynamic dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xFF656565),
                                        fontSize: 16,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ));
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              _userPhoneSelected(newValueSelected);
                            },
                            value: _currentuserPhoneSelected,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                      ///////////////// add delivery address//
                                    _currentuserPhoneSelected=="Self"?Container():
                                      Container(
                                //color: Colors.blue,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                   
                                    Container(
                                      margin: EdgeInsets.only(left:15, right:15),
                                     decoration: BoxDecoration(
                                       color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300],
                                            blurRadius: 10,
                                            //offset: Offset(0.0,3.0)
                                          )
                                        ],
                                      ),
                                      
                                     child:   Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextField(
                                              controller: phoneController,
                                              maxLines: null,
                                              textInputAction: TextInputAction.newline,
                                              keyboardType: TextInputType.number,
                                              style: TextStyle(
                                                  color: Color(0xFF000000)),
                                              cursorColor: Color(0xFF9b9b9b),
                                              decoration: InputDecoration(
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20.0),
                                                      bottomLeft:
                                                          Radius.circular(20.0),
                                                    ),
                                                    borderSide: BorderSide(
                                                        color:Color(0xFFFFFFFF))),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20.0),
                                                        ),
                                                        borderSide: BorderSide(
                                                            color: Color(0xFFFFFFFF)),),
                                                hintText: "Phone Number",
                                                
                                                hintStyle: TextStyle(
                                                    color: Color(0xFF9b9b9b),
                                                    fontSize: 15,
                                                    fontFamily: "sourcesanspro",
                                                    fontWeight: FontWeight.w300),
                                                contentPadding: EdgeInsets.only(
                                                    left: 15,
                                                    bottom: 12,
                                                    right: 15,
                                                    top: 12),
                                                fillColor: Color(0xFFFFFFFF),
                                              ),
                                            ),
                                          ),
                                         
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                    
                           Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                        child: Text(
                          'Payment Option',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                             
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              


                                        /////// payment //
                                        Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              // padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              decoration: BoxDecoration(
                                // color: Colors.yellow,
                                border:
                                    Border.all(color: Colors.black, width: 0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  new ExpansionTile(
                                    title: Row(
                                      children: <Widget>[
                                        Radio(
                                          value: chooseRadio1,
                                          groupValue: selectedRadio,
                                          activeColor: appColor,
                                          onChanged: (val) {
                                            if (this.mounted){
                                            setState(() {
                                              chooseRadio1 = 0;
                                              paymentTypeInfo =
                                                  'Cash on delivery';
                                              chooseRadio2 = -1;
                                              chooseRadio3 = -1;
                                            });
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Cash on delivery',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              letterSpacing: 0.5),
                                        )
                                      ],
                                    ),
                                    children: <Widget>[
                                      Container(
                                        child: Text("Cash On delivery"),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child:
                                                Text("Your Payable Amount:  "),
                                          ),
                                          Container(
                                            child: Text(
                                              total.toStringAsFixed(2)+" TK",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Text("How to pay"),
                                            ),
                                            Container(
                                              child: Text(
                                                  '> Pay Cash to Delivery Man'),
                                            ),
                                            Container(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),


                                Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        // padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        decoration: BoxDecoration(
                          // color: Colors.yellow,
                          border: Border.all(color: Colors.black, width: 0),
                        ),
                        child: Column(
                          children: <Widget>[
                            new ExpansionTile(
                              title: Row(
                                children: <Widget>[
                                  Radio(
                                    value: chooseRadio2,
                                    groupValue: selectedRadio,
                                    activeColor: appColor,
                                    onChanged: (val) {
                                      if (this.mounted){
                                      setState(() {
                                        chooseRadio1 = -1;
                                        chooseRadio2 = 0;
                                        paymentTypeInfo = 'bKash';
                                        chooseRadio3 = -1;
                                      });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/bkash-logo-png.png",
                                    height: 50,
                                    width: 70,
                                  )
                                ],
                              ),
                              children: <Widget>[
                                Container(
                                  child: Text("Bkash Payment"),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Text("Your Payable Amount: "),
                                    ),
                                    Container(
                                      child: Text(
                                        total.toStringAsFixed(2)+" TK",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text("How to pay"),
                                      ),
                                      Container(
                                        child: Text(' > Dial *247#.'),
                                      ),
                                      Container(
                                        child:
                                            Text(' > Select payment option 4.'),
                                      ),
                                      Container(
                                        child: Text(
                                            ' > Write merchant A/C No. 017xxxxxxxx'),
                                      ),
                                      Container(
                                        child: Text(
                                          ' > Write ${userData['id']} in reference'),
                                      ),
                                      Container(
                                        child: Text(
                                            ' > Write ${userData['id']} in counter'),
                                      ),
                                      Container(
                                        child: Text(' > Write Your Amount ' +
                                            total.toStringAsFixed(2)),
                                      ),
                                      Container(
                                        child: Text(' > Write your PIN(XXXX).'),
                                      ),
                                      Container(
                                        child: Text(
                                            ' > You will get a confirmation SMS.'),
                                      ),
                                      Container(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      ///////////////////////////////////////////////////////////

                      ///////////////////////////////////////////////////////////
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        // padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        decoration: BoxDecoration(
                          // color: Colors.yellow,
                          border: Border.all(color: Colors.black, width: 0),
                        ),
                        child: Column(
                          children: <Widget>[
                            new ExpansionTile(
                              title: Row(
                                children: <Widget>[
                                  Radio(
                                    value: chooseRadio3,
                                    groupValue: selectedRadio,
                                    activeColor: appColor,
                                    onChanged: (val) {
                                      if (this.mounted){
                                      setState(() {
                                        chooseRadio1 = -1;
                                        chooseRadio2 = -1;
                                        chooseRadio3 = 0;
                                        paymentTypeInfo = 'Rocket';
                                      });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/roketlogo.png",
                                    height: 50,
                                    width: 70,
                                  )
                                ],
                              ),
                              children: <Widget>[
                                Container(
                                  child: Text("Rocket Payment"),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Text("Your Payable Amount: "),
                                    ),
                                    Container(
                                      child: Text(
                                        total.toStringAsFixed(2)+" TK",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text("How to pay"),
                                      ),
                                      Container(
                                        child: Text(' > Dial *322#.'),
                                      ),
                                      Container(
                                        child:
                                            Text(' > Select payment option 4.'),
                                      ),

                                      Container(
                                        child: Text(
                                            ' > Write merchant A/C No. 017xxxxxxxx'),
                                      ),
                                      Container(
                                        child: Text(
                                            ' > Write ${userData['id']} in reference'),
                                      ),
                                      Container(
                                        child: Text(
                                            ' > Write ${userData['id']} in counter'),
                                      ),
                                      Container(
                                        child: Text(' > Write Your Amount ' +
                                            total.toStringAsFixed(2))
                                      ),
                                      Container(
                                        child: Text(' > Write your PIN(XXXX).'),
                                      ),
                                      Container(
                                        child: Text(
                                            ' > You will get a confirmation SMS.'),
                                      ),
                                      Container(
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),


                    
                                ],
                              ),
                            ),
                              ///////// order ///////
                      Container(
                        margin: EdgeInsets.only(top:10, left:10, right:10),
                        child: AnimatedBuilder(
                                animation: _scaleAnimationController,
                                builder: (context, child) => Transform.scale(
                                      scale: _scaleAnimation.value,
                                      child: InkWell(
                                        onTap: () async {
                                          var now = DateTime.now();

                                          nowTime =int.parse(now.hour.toString());

                                          if (nowTime >= 23 || 
                                              nowTime < 10) {
                                            //10
                                            print("nowTime"); 
                                           // print(nowTime);
                                            _showMessage(
                                                "Sorry! Our service is available from 10am to 9pm.",1);
                                          } else if (addressController.text.isEmpty) {
                                           _showMessage("Please fill delivery address",1);
                                          } 
                                          
                                          else if (_currentuserPhoneSelected=="Others" && phoneController.text.isEmpty) {
                                           _showMessage("Please fill phone number",1);
                                          }
                                            else if (_currentuserPhoneSelected=="Others" && phoneController.text.length <11) {
                                           _showMessage("Please give a valid phone number",1);
                                          } else if (chooseRadio1 == -1 &&
                                              chooseRadio2 == -1 &&
                                              chooseRadio3 == -1) {
                                           
                                                _showMessage("Please Select Payment method",1);
                                          } else {
                                               _scaleAnimationController.forward();
                                               _isLoading?null: _placeOrder();

                                          //   await  _itemInputInvoice();

                                           
                                          }
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: _isLoading?Colors.grey[700]:appColor,
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Align(
                                                    child:
                                                        // animationComplete == false ?
                                                        Text(
                                                _isLoading?"Please wait": "Place Order",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                )
                                                    // :
                                                    // _isError?Text(_isLoading?'Processing...':'CONFIRM ORDER', style: TextStyle(color: Colors.white, fontSize: 14),):
                                                    // Icon(Icons.check, color: Colors.white,)
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                      )
              ],
            ),
                      ),
          )
         ),   
    );
  }

    List<Widget> _cartList() {
    int i = 0;
    subTotal = 0;
    total = 0;

    List<Widget> listCategory = [];
    for (var d in cartList) {
      subTotal +=d['price'] * d['quantity'];
      total = subTotal+shipping_cost;
      i++;
      listCategory.add(Container(
        margin: EdgeInsets.fromLTRB(10, 7, 10, 0),
        //height: 100,
        //color: Colors.red,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 7),
              decoration: BoxDecoration(
                  //color: Colors.red,
                  border: Border(
                bottom: BorderSide(
                  color: i == cartList.length
                      ? Colors.transparent
                      : Colors.grey,
                  width: 0.5,
                ),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    // color: Colors.teal,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10.0, left: 10),
                          child: ClipOval(
                              child: Image.network(
                                     CallApi().getUrl()+ d['productImage'],
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    )
                                 ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              //  color: Colors.red
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                   // _getDiscount();
                                   if (!mounted) return;
                                    setState(() {
                                     // subTotal = 0;
                                   //  discount = 0;
                                   if(d['quantity']<d['stock']){
                                      d['quantity'] = d['quantity'] + 1;
                                   }
                                   else{
                                     Fluttertoast.showToast(
                                              msg: "Stock out",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.redAccent.withOpacity(0.9),
                                              textColor: Colors.white,
                                              fontSize: 13.0);
                                   }
                                   
                                    });
                                   
                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.add,
                                      color: appColor,
                                      //size: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '${d['quantity']}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "sourcesanspro",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // print("object");
                                    // if (d['quantity'] == 1) {
                                    // } else {
                                    //   _getDiscount();
                                if (!mounted) return;
                                       setState(() {
                                    //    // subTotal = 0;
                                    //      discount = 0;
                                    if(d['quantity']>1)
                                         d['quantity'] = d['quantity'] - 1;
                                   

                                          });
                                  
                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.remove,
                                      color: appColor,
                                      //size: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 3 + 20,
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                d['productName'] == null
                                    ? "---"
                                    : '${d['productName']}',
                                // "${d.quantity}x ${d.item.name}",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "sourcesanspro",
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                d['price'] == null
                                    ? "---"
                                    : '${d['price'] * d['quantity']} Tk',

                                //  "\$${(d.item.price * d.quantity).toStringAsFixed(2)}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: appColor,
                                    fontFamily: "sourcesanspro",
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                       
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //width: 120,
                    //  color: Colors.red,
                    alignment: Alignment.topRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            child: Icon(
                              Icons.close,
                              color: appColor,
                            ),
                            onTap: () {
                               _deleteCart(d);

                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          //  child: GestureDetector(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          //  child: GestureDetector(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

///////////////////
          ],
        ),
      ));
    }

    return listCategory;
  }
  _deleteCart(d) async{


    // for (var data in cartList){

    // }
    if (!mounted) return;
setState(() {
  cartList.remove(d);
  cartProductList.remove(d['productId']);
});

 SharedPreferences localStorage = await SharedPreferences.getInstance();
       localStorage.setString('cart', json.encode(cartList));

    

  }    

  _placeOrder() async{


      List orderList  = [];

      for ( var d in cartList){
          orderList.add({
            "productId":d['productId'],
            "quantity":d['quantity']
          });
      }

     if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    var data = {

      "userId":userData['id'],
      "address":addressController.text,
      "phone":_currentuserPhoneSelected=="Self"?userData['phone']:phoneController.text,
      "shippingPrice":shipping_cost,
      "subTotal":subTotal,
      "grandTotal":total,
      "paymentType":paymentTypeInfo,
      "orderItems":orderList  
     
    };

    var res = await CallApi().postData(data, '/api/addOrder');
    var body = json.decode(res.body);

     if (res.statusCode == 200) {
     
    _showMessage("Order Placed Successfully", 2);
     SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('cart');
   
     Navigator.push( context, SlideLeftRoute(page: ConfirmPage()));

     }
       
      else{
         _showMessage("Something Wrong! Try again",1);
      }
   
if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

_showMessage(msg, numb) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: numb == 1 ? Colors.red.withOpacity(0.9) : Colors.grey,
        textColor: Colors.white,
        fontSize: 13.0);
  }

  }                                       

