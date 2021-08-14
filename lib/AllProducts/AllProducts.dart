import 'dart:convert';
import 'package:Easy_Shopping/Card/ProductsCard/ProductsCard.dart';
import 'package:Easy_Shopping/ErrorLogIn/ErrorLogIn.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/api/api.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:Easy_Shopping/redux/action.dart';
import 'package:Easy_Shopping/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  var body, body1, body2;
  int catId = 0;
  bool _isLoading = true;
  bool isSearch = false;
  bool isFilter = false;
  TextEditingController searchController = new TextEditingController();
  String search = "";
  String result = '',
      maxPrice = "",
      minPrice = "",
      cat = "",
      catName = "",
   
      orderName = "",
      nameOrder = "",
      orderType = "",
      typeOrder = "";
  var catList, user;
  List filterList=[
    {
      'image':"assets/images/products.png",
      "name":"rice",
      "price":"500 Tk",
      'discount':10
    },
    {
      'image':"assets/images/products.png",
      "name":"rice",
      "price":"500 Tk",
      'discount':10
    },
    {
      'image':"assets/images/products.png",
      "name":"rice",
      "price":"500 Tk",
      'discount':10
    },
    {
      'image':"assets/images/products.png",
      "name":"rice",
      "price":"500 Tk",
      'discount':10
    },
    {
      'image':"assets/images/products.png",
      "name":"rice",
      "price":"500 Tk",
      'discount':10
    },
    {
      'image':"assets/images/products.png",
      "name":"rice",
      "price":"500 Tk",
      'discount':10
    },
    {
      'image':"assets/images/products.png",
      "name":"rice",
      "price":"500 Tk",
      'discount':10
    },
    {
      'image':"assets/images/products.png",
      "name":"rice",
      "price":"500 Tk",
      'discount':10
    },
    {
      'image':"assets/images/products.png",
      "name":"rice",
      "price":"500 Tk",
      'discount':10
    },
  ];
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();


  List storeProductList=[];

  @override
  void initState() {
    // _getUserInfo();
    // getFilterData();
    // getCategory();
     _showProducts();
  
    super.initState();
  }

      Future<void> _showProducts() async {
    var res = await CallApi().getData('/api/showAllProduct');

    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      print(body);

      store.dispatch(ProductListAction(body['Product']));
      storeProductList  = store.state.productList;
    } else if (res.statusCode == 401) {
      Navigator.push(context, SlideLeftRoute(page: ErrorLogIn()));
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong!! Try again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appColor.withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 13.0);
    }
    store.dispatch(ProductLoadingAction(false));
  }

  
  Future<void> _pull() async{
     _showProducts();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    if (userJson != null) {
      var users = json.decode(userJson);
      setState(() {
        user = users;
      });
    }
    print("user");
    print(user);
  }

  Future<void> getFilterData() async {




print("storeProductList");
print(storeProductList);
 store.dispatch(ProductListAction([]));
 store.dispatch(ProductLoadingAction(true));

    var res = await CallApi().getData(
        '/api/searchProduct/$search');
    body = json.decode(res.body);

  //  print(body);

    if (res.statusCode == 200) {
     
    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      print(body);

      store.dispatch(ProductListAction(body['Product']));
    } else if (res.statusCode == 401) {
      Navigator.push(context, SlideLeftRoute(page: ErrorLogIn()));
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong!! Try again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appColor.withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 13.0);
    }
    store.dispatch(ProductLoadingAction(false));
    }

    setState(() {
      _isLoading = false;
    });
  }

 

  
  @override
  Widget build(BuildContext context) {
    return  StoreConnector<AppState, AppState>(
          ////// this is the connector which mainly changes state/ui
          converter: (store) => store.state,
          builder: (context, items) {
            return Scaffold(
        appBar: new AppBar(
          backgroundColor: appColor,
          automaticallyImplyLeading: false,
          title: isSearch == false
              ? Text("All Products")
              : Container(
                  height: 50.0,
                  margin: EdgeInsets.only(right: 0, left: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Colors.white),
                  child: TextField(
                    cursorColor: grey,
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: appColor,
                      ),
                      hintText: "Search",
                      
                      hintStyle: TextStyle(color: grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 5.0, top: 15.0),
                     // suffixIcon: 
                      // search != ""
                      //     ? IconButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             searchController.text = "";
                      //             search = "";
                      //           });
                      //         },
                      //         icon: Icon(Icons.arrow_forward),
                      //         color: Colors.grey,
                      //       )
                      //     :
                          //  Icon(
                          //     Icons.cancel,
                          //     color: Colors.transparent,
                          //   ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        //  _searchShop();
                        filterList = null;
                        search = val;
                        getFilterData();
                      });
                    },
                  ),
                ),
          actions: <Widget>[
            Container(
              height: 45.0,
              padding: EdgeInsets.only(bottom: 5, right: 10, top: 5),
              child: GestureDetector(
                onTap: () {
                  //_filterPage();
                },
                child: Container(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSearch == false) {
                              isSearch = true;
                            } else {
                              isSearch = false;
                              searchController.text = "";
                              store.dispatch(ProductListAction(storeProductList));
                            }
                          });
                        },
                        child: Container(
                            child: Icon(
                                isSearch == true ? Icons.close : Icons.search,
                                color: Colors.white)),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       if (isFilter == false) {
                      //         isFilter = true;
                      //       } else {
                      //         filterList = null;
                      //         isFilter = false;
                      //        // getFilterData();
                      //       }
                      //     });
                      //   },
                      //   child: Container(
                      //       child: Icon(
                      //           isFilter == true ? Icons.done : Icons.filter_list,
                      //           color: Colors.white)),
                      // )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: store.state.productLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : store.state.productList.length == 0
                ? Center(
                    child: Container(
                    child: Text("No products found",),
                  ))
                : SafeArea(
                    child: RefreshIndicator(
                    onRefresh: _pull,
                    child: Container(
                          margin: EdgeInsets.only(
                            left: 0,
                            right: 0,
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.only(left: 5, right: 5, top: 4, bottom: 5),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    top: isFilter == false ? 0 : 60),
                                child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio:
                                                  (MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          3) /
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          4),
                                            ),
                                            itemBuilder:
                                                (BuildContext context, int index) =>
                                                    new Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: ProductsCard(
                                                  user, store.state.productList[index]),
                                            ),
                                            itemCount: store.state.productList.length,
                                          )
                                     
                                 
                              ),
                              // isFilter == false
                              //     ? Container()
                              //     : Container(
                              //         child: Column(
                              //           children: <Widget>[
                              //             Container(
                              //               color: Colors.white,
                              //               padding: EdgeInsets.only(top: 5),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.spaceEvenly,
                              //                 children: <Widget>[
                              //                   Expanded(
                              //                     child: GestureDetector(
                              //                       onTap: () {
                              //                         selection(1);
                              //                       },
                              //                       child: Container(
                              //                         child: Row(
                              //                           mainAxisAlignment:
                              //                               MainAxisAlignment
                              //                                   .center,
                              //                           children: <Widget>[
                              //                             Icon(
                              //                               Icons.attach_money,
                              //                               size: 11,
                              //                               color: minController
                              //                                               .text ==
                              //                                           "" &&
                              //                                       maxController
                              //                                               .text ==
                              //                                           ""
                              //                                   ? Colors.black54
                              //                                   : appColor,
                              //                             ),
                              //                             Text(
                              //                               minController.text ==
                              //                                           "" &&
                              //                                       maxController
                              //                                               .text ==
                              //                                           ""
                              //                                   ? "Total_Price"
                              //                                   : minController.text ==
                              //                                               "" &&
                              //                                           maxController
                              //                                                   .text !=
                              //                                               ""
                              //                                       ?"Max"+": ${maxController.text}"
                              //                                       : minController.text !=
                              //                                                   "" &&
                              //                                               maxController.text ==
                              //                                                   ""
                              //                                           ? "Min"+":  ${minController.text}"
                              //                                           :"Min"+" ${minController.text}"+ 
                              //                                          "Max" +"${maxController.text}",
                              //                               maxLines: 1,
                              //                               overflow: TextOverflow
                              //                                   .ellipsis,
                              //                               style: TextStyle(
                              //                                   fontSize: 12,
                              //                                   color: minController
                              //                                                   .text ==
                              //                                               "" &&
                              //                                           maxController
                              //                                                   .text ==
                              //                                               ""
                              //                                       ? Colors.black54
                              //                                       : appColor),
                              //                             ),
                              //                           ],
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                   Container(
                              //                       height: 20,
                              //                       child: VerticalDivider(
                              //                         color: appColor,
                              //                       )),
                              //                   Expanded(
                              //                     child: GestureDetector(
                              //                       onTap: () {
                              //                         selection(2);
                              //                       },
                              //                       child: Container(
                              //                         alignment: Alignment.center,
                              //                         child: Row(
                              //                           mainAxisAlignment:
                              //                               MainAxisAlignment
                              //                                   .center,
                              //                           children: <Widget>[
                              //                             Icon(
                              //                               Icons.category,
                              //                               size: 10,
                              //                               color: cat == ""
                              //                                   ? Colors.black54
                              //                                   : appColor,
                              //                             ),
                              //                             Text(
                              //                                 catName == ""
                              //                                     ? "Category"
                              //                                     : "$catName",
                              //                                 maxLines: 1,
                              //                                 overflow: TextOverflow
                              //                                     .ellipsis,
                              //                                 style: TextStyle(
                              //                                     fontSize: 12,
                              //                                     color: cat == ""
                              //                                         ? Colors
                              //                                             .black54
                              //                                         : appColor)),
                              //                           ],
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                   Container(
                              //                       height: 20,
                              //                       child: VerticalDivider(
                              //                         color: appColor,
                              //                       )),
                                               
                              //                 ],
                              //               ),
                              //             ),
                              //             Container(
                              //               color: Colors.white,
                              //               padding:
                              //                   EdgeInsets.only(top: 10, bottom: 5),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.spaceEvenly,
                              //                 children: <Widget>[
                              //                   Expanded(
                              //                     child: GestureDetector(
                              //                       onTap: () {
                              //                         selection(4);
                              //                       },
                              //                       child: Container(
                              //                         child: Row(
                              //                           mainAxisAlignment:
                              //                               MainAxisAlignment
                              //                                   .center,
                              //                           children: <Widget>[
                              //                             Icon(
                              //                               Icons.line_style,
                              //                               size: 10,
                              //                               color: orderName == ""
                              //                                   ? Colors.black54
                              //                                   : appColor,
                              //                             ),
                              //                             Text(
                              //                                 nameOrder == ""
                              //                                     ? "Order_Name"
                              //                                     : nameOrder,
                              //                                 maxLines: 1,
                              //                                 overflow: TextOverflow
                              //                                     .ellipsis,
                              //                                 style: TextStyle(
                              //                                     fontSize: 12,
                              //                                     color: orderName ==
                              //                                             ""
                              //                                         ? Colors
                              //                                             .black54
                              //                                         : appColor)),
                              //                           ],
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                   Container(
                              //                       height: 20,
                              //                       child: VerticalDivider(
                              //                         color: appColor,
                              //                       )),
                              //                   Expanded(
                              //                     child: GestureDetector(
                              //                       onTap: () {
                              //                         selection(5);
                              //                       },
                              //                       child: Container(
                              //                         child: Row(
                              //                           mainAxisAlignment:
                              //                               MainAxisAlignment
                              //                                   .center,
                              //                           children: <Widget>[
                              //                             Icon(
                              //                               Icons.line_weight,
                              //                               size: 10,
                              //                               color: orderType == ""
                              //                                   ? Colors.black54
                              //                                   : appColor,
                              //                             ),
                              //                             Text(
                              //                                 typeOrder == ""
                              //                                     ?"Order_Type"
                              //                                     :typeOrder,
                              //                                 style: TextStyle(
                              //                                     fontSize: 12,
                              //                                     color: orderType ==
                              //                                             ""
                              //                                         ? Colors
                              //                                             .black54
                              //                                         : appColor)),
                              //                           ],
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       )
                            ],
                          )),
                    ),
                  ),
      );
          }
    );
         
  }

  Container priceInputField(String label, TextEditingController control) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              // width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 5),
              child: Text(
              label,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Oswald',
                    fontWeight: FontWeight.w400),
              )),
          Container(
            //   width: ,
            padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
            margin: EdgeInsets.only(top: 13),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
                border: Border.all(width: 0.2, color: Colors.grey)),
            child: TextFormField(
              cursorColor: Colors.grey,
              controller: control,
              keyboardType: TextInputType.number,
              autofocus: false,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                //  hintText: hint,
                hintStyle: TextStyle(fontSize: 14),
                //labelText: 'Enter E-mail',
                contentPadding: EdgeInsets.fromLTRB(0.0, 8.0, 20.0, 0.0),
                border: InputBorder.none,
              ),
              validator: (val) => val.isEmpty ? 'Field is empty' : null,
              // onSaved: (val) => name = val,
              //validator: _validateEmail,
            ),
          ),
        ],
      ),
    );
  }

  void selection(int num) {
    num == 1
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: Column(
                  children: <Widget>[
                    new Text("Price" ,),
                    Divider(
                      color: Colors.grey[400],
                    ),
                    priceInputField("Min_Price", minController),
                    priceInputField("Max_Price", maxController),
                  ],
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            maxPrice = maxController.text;
                            minPrice = minController.text;
                          });
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                      child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.grey),
                                  )))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            maxPrice = maxController.text;
                            minPrice = minController.text;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new OutlineButton(
                                borderSide: BorderSide(
                                    color: appColor,
                                    style: BorderStyle.solid,
                                    width: 1),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(50.0)),
                                child: new Text(
                                 "Done",
                                  
                                  style: TextStyle(color: appColor),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          )
        : num == 2
            ? showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      title: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(top: 5, bottom: 15),
                                child: new Text("Category")),
                            Divider(
                              height: 0,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      ),
                      content: Container(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: 40,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:
                                    List.generate(catList.length, (index) {
                                  return categoryList(catList[index]);
                                })),
                          ),
                        ),
                      ));
                },
              )
          
                : num == 4
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              title: Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 15),
                                        child: new Text("Order_Name")),
                                    Divider(
                                      height: 0,
                                      color: Colors.grey[400],
                                    ),
                                  ],
                                ),
                              ),
                              content: Container(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      bottom: 40,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        nameList("ID"),
                                        nameList("Name"),
                                        nameList("Price"),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        },
                      )
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              title: Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 15),
                                        child: new Text("Order_Type")),
                                    Divider(
                                      height: 0,
                                      color: Colors.grey[400],
                                    ),
                                  ],
                                ),
                              ),
                              content: Container(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      bottom: 40,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        // typeList("A - Z"),
                                        // typeList("Z - A"),
                                         typeList( nameOrder=="Name"?"A_to_Z":nameOrder=="Price"?"Low_to_High":"First_to_Last"),
                                          typeList( nameOrder=="Name"?"Z_to_A":nameOrder=="Price"?"High_to_Low":"Last_to_First"),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        },
                      );
  }

  Container categoryList(var catList) {
    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
            int cats = catList.id;
            catId = catList.id;
            cat = "$cats";
            catName = catList.name;
          //  getSubcategory();
          });
          Navigator.pop(context);
        },
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(bottom: 12, top: 12, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  catList.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }

 

  Container nameList(String name) {
    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
           if (name == "ID") {
              orderName = "id";
            } else if(name=="Name"){
              orderName = "name";
            }
            else if(name=="Price"){
              orderName = "price";
            }

            nameOrder = name;
            print(nameOrder);
            Navigator.pop(context);
          });
        },
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(bottom: 12, top: 12, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container typeList(String type) {
    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
             if (type == "A_to_Z" || type ==  "Low_to_High" || type =="First_to_Last") {
              orderType = "asc";
            } else if(type == "Z_to_A" || type == "High_to_Low" || type =="Last_to_First"){
              orderType = "desc";
            }

            typeOrder = type;
            Navigator.pop(context);
          });
        },
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(bottom: 12, top: 12, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                type,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}


