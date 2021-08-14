import 'dart:convert';
import 'package:Easy_Shopping/Cart/CartPage.dart';
import 'package:Easy_Shopping/CreateAddress/CreateAddress.dart';
import 'package:Easy_Shopping/EditAddress/EditAddress.dart';
import 'package:Easy_Shopping/Navigation/Navigation.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
class ShowAddress extends StatefulWidget {

  

  @override
  _ShowAddressState createState() => _ShowAddressState();
}

class _ShowAddressState extends State<ShowAddress> {
  var responce;
  var data;
  bool _isLoading = true;
  var id = "";
  List<String> addressDelList = [];

  List addressList=[
     { "address_title":"home",
       'house_no':"sunam",
    'street_road':"34",
    'area':"bazer"},

     { "address_title":"home",
       'house_no':"sunam",
    'street_road':"34",
    'area':"bazer"},


     { "address_title":"home",
       'house_no':"sunam",
    'street_road':"34",
    'area':"bazer"},
    
   
    
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
    //Scaffold.of(context).showSnackBar(snackBar);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState() {
  
   // loadShareData();
   
    super.initState();
  }

  String dataSharePre = '';
  String nameKey = "_key_name";
  Future<void> loadShareData() async {
    dataSharePre = await loadData();
    id = dataSharePre;


    await _showAllAddress();
    print(dataSharePre);
  }


  Future<String> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(nameKey);
  }

  Future _getLocalBestProductsData(key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var localbestProductsData = localStorage.getString(key);
    if (localbestProductsData != null) {
      data = json.decode(localbestProductsData);
      print("dataLocal.length");
      print(data.length);
      if (this.mounted){
      setState(() {
        _isLoading = false;
      });
      }
    }
  }

  Future<void> _showAllAddress() async {
    var key = 'address-list';
     await _getLocalBestProductsData(key);
     String url = "https://admin.duare.net/api/address_list.php";//?id=$id";
 
   // responce = await http.get(url);
      var responce = await http.post(url, body: {
        
        "id": dataSharePre,
       
    });
  

    data = json.decode(responce.body);
  
    print(data);
    print("data.length");
    print(data.length);

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

     SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(key, json.encode(data));
  }

  Future<bool> _onWillPop() async {

    Navigator.of(context).pop();
 
    // if( visitaddress == "settings"){
     
    //     Navigator.push( context, SlideLeftRoute(page: Navigation()));
    // }
    // else{
    //     Navigator.push( context, SlideLeftRoute(page: CartPage()));
    // }
                 
                 
             
   }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          //backgroundColor: Colors.transparent, 
          backgroundColor:appColor,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
    //               if( visitaddress == "settings"){
    //     Navigator.push( context, SlideLeftRoute(page: Navigation()));
    // }
    // else{
    //     Navigator.push( context, SlideLeftRoute(page: CartPage()));
    // }
    Navigator.of(context).pop();
         
                },
              );
            },
          ),
          title: Text(
            'My Address',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
         

          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateAddress("", "")),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: appColor),
        body:
        //  _isLoading
        //     ? Center(
        //         child:
        //             Container(child: Text("Please wait to show all address...")))
          //  : 
            SafeArea(
                child: RefreshIndicator(
                  onRefresh: _showAllAddress,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: addressList.length == 0
                        ? Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height - 100,
                            child: Text("No address is available now"))
                        : Container(
                            // height: MediaQuery.of(context).size.height,
                            child: Column(
                              // mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                    color: Colors.white,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: _showAddressList())),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
      ),
    );
  }

  List<Widget> _showAddressList() {
    List<Widget> list = [];
    int i = 0;
    // print(addressDelList);
    // int checkIndex=0;
    for (var d in addressList) {
      i++;
      list.add(
        GestureDetector(
          onTap: () {
           
                            if( visitaddress == "settings"){
       
    }
   

    else{
       var dataDeliveryAddress = {
              "house": d['house_no'] == "" || d['house_no'] == null
                  ? ""
                  : d['house_no'],
              "road": d['street_road'] == "" || d['street_road'] == null
                  ? ""
                  : d['street_road'],
              "area": d['area'] == "" || d['area'] == null ? "" : d['area']
            };
      //  _saveAddress(dataDeliveryAddress);
       // Navigator.push( context, SlideLeftRoute(page: CartPage()));
    }
          
            //  print("rfdrf");
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => CartPage()));
          },
          child: Column(
            children: <Widget>[
             Container(
                      padding: EdgeInsets.only(left: 15, right: 5, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(
                                  Icons.home,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      //  padding: EdgeInsets.only(left: 15, right: 120),
                                      child: Text(
                                        d['address_title'] == "" ||
                                                d['address_title'] == null
                                            ? "Address $i"
                                            : d['address_title'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    d['house_no'] == "" || d['house_no'] == null
                                        ? Container()
                                        : Container(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                              d['house_no'] == "" ||
                                                      d['house_no'] == null
                                                  ? ""
                                                  : "House no: " +
                                                      d['house_no'],
                                            ),
                                          ),
                                    d['street_road'] == "" ||
                                            d['street_road'] == null
                                        ? Container()
                                        : Container(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                              d['street_road'] == "" ||
                                                      d['street_road'] == null
                                                  ? ""
                                                  : "Road: " + d['street_road'],
                                            ),
                                          ),
                                    d['area'] == "" || d['area'] == null
                                        ? Container()
                                        : Container(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                              d['area'] == "" ||
                                                      d['area'] == null
                                                  ? ""
                                                  : "Area : " + d['area'],
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                                              onTap: () {
                                                _editDeleteBottomSheet();
                                              },
                                                      child: Container( 
              margin: EdgeInsets.only(left: 10, right: 15),
                              child:  Icon(
                                Icons.more_horiz,
                                 color: Colors.grey,
                                          )
                            
                              // child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: <Widget>[
                              //       Container(
                                    
                              //         margin: EdgeInsets.only(left: 10, right: 15),
                              //         child: GestureDetector(
                              //           onTap: () {
                              //             Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                     builder: (context) => EditAdress(
                              //                           d['id'],
                              //                           d['address_title'],
                              //                           d['house_no'],
                              //                           d['street_road'],
                              //                           d['area'],
                              //                         )));
                              //           },
                              //           child: Icon(
                              //             Icons.edit,
                              //             color: Colors.grey[900],
                              //             size: 30,
                              //           ),
                              //         ),
                              //       ),
                              //       Container(
                                      
                              //        // margin: EdgeInsets.only(left: 10, right: 5),
                              //         child: GestureDetector(
                              //           onTap: () {
                              //             showItemAlert(d);
                              //           },
                              //           child: Icon(
                              //             Icons.delete,
                              //             color: Colors.red[400],
                              //             size: 30,
                              //           ),
                              //         ),
                              //       )
                              //     ]),
                            ),
                          ),
                        ],
                      ),
                    ),

              //  addressDelList.contains(d['id'])
              //                         ? Container(): Divider()

              addressDelList.contains(d['id'])
                  ? i == data.length
                      ? Container()
                      : Container(
                          //height: 30,
                          )
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Divider(color: Colors.grey),
                    )
            ],
          ),
        ),
      );
    }

    return list;
  }

  void showItemAlert(var d) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: Text(
            "Are you sure want to delete this address?",
            // textAlign: TextAlign.,
            style: TextStyle(
                color: Color(0xFF000000),
               
               
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          content: Container(
              height: 70,
              width: 250,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        width: 110,
                        height: 45,
                        margin: EdgeInsets.only(
                          top: 25,
                          bottom: 15,
                        ),
                        child: OutlineButton(
                          child: new Text(
                            "No",
                            style: TextStyle(color: Colors.black),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.5),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                        )),
                    Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF1741E5).withOpacity(0.9),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        width: 110,
                        height: 45,
                        margin: EdgeInsets.only(top: 25, bottom: 15),
                        child: //_buttonFunction
                            OutlineButton(
                                // color: Colors.greenAccent[400],
                                child: new Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  //_deleteItem(d);
                                },
                                borderSide:
                                    BorderSide(color: Colors.green, width: 0.5),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0))))
                  ])),
        );
        //return SearchAlert(duration);
      },
    );
  }

  void _deleteItem(var d) async {
    // setState(() {
    //   _isLoading = true;
    // });

    //   print(d['id']);

    var response =
        await http.post("https://admin.duare.net/api/address_delete.php", body: {
      "id": d['id'],
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
     if (this.mounted){
        setState(() {
        data.remove(d);
      });
     }
      addressDelList.add(d['id']);
      print(data.length);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('address-list', json.encode(data));

      _showAllAddress();
    } else {
      _showMsg("Something went wrong!Try again");
    }

    //   setState(() {
    //   _isLoading = false;
    // });
  }

  void _saveAddress(var delData) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString("delivery_Address", json.encode(delData));
  }

  
  void _editDeleteBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: 
                Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: new Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        title: Row(
                          children: [
                            new Text('Edit',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: "Oswald")),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          // Navigator.push(
                                // context, SlideLeftRoute(page: EditName(d)));
                        }),
                   
                  
                    ListTile(
                        leading: new Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                        title: Row(
                          children: [
                            new Text('Remove',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: "Oswald")),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          _showDeleteDialog();
                        }),
                  ],
                ));
          });
        });
  }

   Future<Null> _showDeleteDialog() async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    "Are you sure want to delete?",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400),
                  )),
              actions: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontFamily: 'Oswald',
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 10),
                        child: GestureDetector(
                          onTap: () async {
                            
                            
                            Navigator.of(context).pop();
                            _isLoading ? _showProcessingDialog() : null;
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              color: appColor,
                              fontSize: 15,
                              fontFamily: 'Oswald',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
        });
  }

    Future<Null> _showProcessingDialog() async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 28,
                      width: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.grey[400]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12),
                      child: Text(
                        "Processing...",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ));
          });
        });
  }
}
