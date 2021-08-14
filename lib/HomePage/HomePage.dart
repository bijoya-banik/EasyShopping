import 'dart:convert';

import 'package:Easy_Shopping/AllProducts/AllProducts.dart';
import 'package:Easy_Shopping/Category/Category.dart';
import 'package:Easy_Shopping/CategoryProducts/CategoryProducts.dart';
import 'package:Easy_Shopping/ErrorLogIn/ErrorLogIn.dart';
import 'package:Easy_Shopping/Navigation/Navigation.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/OfferProducts/OfferProducts.dart';
import 'package:Easy_Shopping/ProductDetails/ProductDetails.dart';
import 'package:Easy_Shopping/api/api.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:Easy_Shopping/redux/action.dart';
import 'package:Easy_Shopping/redux/state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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

  List bannerList = [
    "assets/images/img5.jpg",
    "assets/images/img2.jpg",
    "assets/images/img4.png",
    "assets/images/img3.jpg",
  ];


  


  @override
  void initState() {
    bottomNavIndex = 0;

      _showCategory();
      _showOffers();

    super.initState();
  }

   Future<void> _showCategory() async {
    var res = await CallApi().getData('/api/showAllCategory');

    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      print(body);

      store.dispatch(CategoryListAction(body['category']));
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
    store.dispatch(CategoryLoadingAction(false));
  }

  
    Future<void> _showOffers() async {
    var res = await CallApi().getData('/api/showOfferProduct');

    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      print(body);

      store.dispatch(OfferProductListAction(body['Product']));
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
    store.dispatch(OfferProductLoadingAction(false));
  }

  imageCarousel() {
    return Container(
      color: Colors.white,
      child: bannerList.length == 0
          ? Container(
              color: Colors.white,
              height: 180,
              child: Image.asset(
                "assets/images/products.png",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 180,
              ))
          : Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 180.0,
                    //initialPage: 0,
                    enlargeCenterPage: false,
                    autoPlay: true,
                    reverse: false,
                    enableInfiniteScroll: true,
                    viewportFraction: 1.0,
                    autoPlayInterval: Duration(seconds: 8),
                    autoPlayAnimationDuration: Duration(milliseconds: 2000),
                    scrollDirection: Axis.horizontal,
                  ),
                  // onPageChanged: (index) {
                  //   setState(() {
                  //     //_current = index;
                  //   });
                  // },
                  items: bannerList.map((imgUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          //margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: shopNow(imgUrl),
                        );
                      },
                    );
                  }).toList(),
                ),
                Positioned(
                  bottom: 5,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //             context, SlideLeftRoute(page: ProductsDetailsPage()));
                    },
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                             // bottomNavIndex = 1
                              Navigator.push(context,
                                  SlideLeftRoute(page: AllProducts()));
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      //width: MediaQuery.of(context).size.width / 3 - 20,
                                      alignment: Alignment.bottomRight,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        gradient: LinearGradient(
                                          begin: Alignment.centerRight,
                                          end: Alignment.topLeft,
                                          stops: [0.1, 0.4, 0.6, 0.9],
                                          colors: [
                                            Colors.grey[400],
                                            Colors.grey[300],
                                            Colors.grey[200],
                                            Colors.grey[200],
                                          ],
                                        ),
                                      ),
                                      //width: 320,
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Shop Now",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child: Icon(
                                                Icons.keyboard_arrow_right,
                                                color: Colors.black,
                                                size: 20,
                                              ))
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Future<void> _pull() async{
     _showCategory();
     _showOffers();
  }

  @override
  Widget build(BuildContext context) {
    return  StoreConnector<AppState, AppState>(
          ////// this is the connector which mainly changes state/ui
          converter: (store) => store.state,
          builder: (context, items) {
            return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appColor,
          title: Text("HomePage"),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
            child: RefreshIndicator(
              onRefresh: _pull,
                          child: SingleChildScrollView(
                  child: Column(
          children: [
              ///////////// slide start/////////
              Container(
                child: imageCarousel(),
              ),

              /////////////////   category  start /////
           
           
              store.state.categoryLoading
                  ? Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 50, bottom:50),
                          child: CircularProgressIndicator()))
                  : store.state.categoryList.length == 0
                      ? Container()
                      : 
                      Column(
                          children: <Widget>[
                             Container(
                                   margin:
                                       EdgeInsets.only(top: 25, bottom: 10),
                                   child: Row(
                                     mainAxisAlignment:
                                         MainAxisAlignment.spaceBetween,
                                     children: <Widget>[
                                       Container(
                                         margin: EdgeInsets.only(left: 20),
                                         alignment: Alignment.bottomLeft,
                                         child: Text(
                                         "Category",
                                           
                                           maxLines: 1,
                                           textAlign: TextAlign.left,
                                           overflow: TextOverflow.ellipsis,
                                           style: TextStyle(
                                               fontSize: 18,
                                               color: black,
                                               fontWeight: FontWeight.bold),
                                         ),
                                       ),
                                       Container(
                                         margin: EdgeInsets.only(right: 15),
                                         alignment: Alignment.bottomRight,
                                         child: GestureDetector(
                                           onTap: () {
                                             Navigator.push(
                                                 context,
                                                 SlideLeftRoute(
                                                     page:
                                                         CategoryPage()));
                                            
                                           },
                                           child: Text(
                                            "See All",
                                             maxLines: 1,
                                             textAlign: TextAlign.left,
                                             overflow: TextOverflow.ellipsis,
                                             style: TextStyle(
                                                 fontSize: 12,
                                                 color: appColor.withOpacity(0.7),
                                                 fontWeight: FontWeight.bold),
                                           ),
                                         ),
                                       ),
                                       // Container(
                                       //     child: Icon(
                                       //   Icons.keyboard_arrow_right,
                                       //   color: Color(0XFF09324B),
                                       //   size: 20,
                                       // )),
                                     ],
                                   ),
                                 ),
                            Container(
                              margin: EdgeInsets.only(top: 0),
                              //  padding: EdgeInsets.fromLTRB(13, 5, 0, 0),
                              height: MediaQuery.of(context).size.height / 6,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: store.state.categoryList.length,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return
                                        // index > 4
                                        //     ? Container()
                                        //     :
                                        Row(
                                      children: <Widget>[
                                        //////////
                                        GestureDetector(
                                          onTap: () {
                                          
                                              Navigator.push(
                                                  context,
                                                  SlideLeftRoute(
                                                      page: CategoryProducts(
                                                          store.state.categoryList[index])));
                                            
                                          },
                                          child: Container(
                                            //width
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 8, left: 10),
                                                  padding: EdgeInsets.all(3),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      11,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(8.0)),
                                                    border: Border.all(
                                                        color: Colors.grey[350]),
                                                  ),
                                                  child: 
                                                  // category[index]
                                                  //                 ['cat_img'] ==
                                                  //             null ||
                                                  //         category[index]
                                                  //                 ['cat_img'] ==
                                                  //             ""
                                                  //     ? 
                                                      Image.network(CallApi().getUrl()+store.state.categoryList[index]['categoryImage']),
                                                      // : CachedNetworkImage(
                                                      //     imageUrl: category[index]
                                                      //         ['cat_img'],
                                                      //     imageBuilder: (context,
                                                      //             imageProvider) =>
                                                      //         Container(
                                                      //       decoration:
                                                      //           BoxDecoration(
                                                      //         image:
                                                      //             DecorationImage(
                                                      //           image:
                                                      //               imageProvider,
                                                      //         ),
                                                      //       ),
                                                      //     ),
                                                      //     placeholder:
                                                      //         (context, url) =>
                                                      //             Container(),
                                                      //     errorWidget: (context,
                                                      //             url, error) =>
                                                      //         Icon(Icons.error),
                                                      //   ),
                                                 
                                                ),
                                              
                                                Container(
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.only(
                                                      left: 15,
                                                      right: 10,
                                                      top: 6,
                                                      bottom: 6),
                                                  child: Text(
                                                    store.state.categoryList[index]['categoryName'],
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),


                      ///////////    products start ///////
                      Container(
                                        margin:
                                            EdgeInsets.only(top: 25, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 20),
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                               "Offer Products",
                                                
                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color:black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(right: 15),
                                              alignment: Alignment.bottomRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                 Navigator.push( context, SlideLeftRoute(page: OfferProducts()));
                                                },
                                                child: Text(
                                                 "See All",
                                                  
                                                  maxLines: 1,
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: appColor.withOpacity(0.7),
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            // Container(
                                            //     child: Icon(
                                            //   Icons.keyboard_arrow_right,
                                            //   color: Color(0XFF09324B),
                                            //   size: 20,
                                            // )),
                                          ],
                                        ),
                                      ),
                            ///////// products List //////

                                     store.state.offerProductLoading
                                          ? Center(
                                              child: CircularProgressIndicator(),
                                            )
                                          : store.state.offerProductList.length == 0
                                              ? Center(
                                                  child: Container(
                                                  margin: EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    "No Offers available"
                                                      ),
                                                ))
                                              : 
                                              Container(
                                                  height: 180,
                                                  //color: Colors.red,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: EdgeInsets.only(left: 8),
                                                  child:
                                                      //   MediaQuery.of(context).orientation ==
                                                      //     Orientation.portrait
                                                      // ?

                                                      /////////// New Arrival Portrait start //////

                                                      ListView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                                int index) =>
                                                            Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 5,
                                                          top: 0,
                                                          left: 3),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(10),
                                                                bottomRight:
                                                                    Radius.circular(
                                                                        10)),
                                                      ),
                                                      child: Container(
        //color: Colors.white,
        width: MediaQuery.of(context).size.width /2-50,
        child: InkWell(
          
         
          onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetails(store.state.offerProductList[index])),
              );

          
          },
          child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              title: Stack(
                children: <Widget>[
                  Card(
                    elevation: 1.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0.5,
                            color: Color(0XFF377FA8).withOpacity(0.5),
                            //offset: Offset(6.0, 7.0),
                          ),
                        ],
                      ),
                      height: 180,
                      width: MediaQuery.of(context).size.width / 2 - 35,
                      padding: EdgeInsets.only(bottom: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 100,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 2 - 35,
                                child: Image.network(
                                  CallApi().getUrl()+store.state.offerProductList[index]['productImage'],
                                  height: 100,
                                  width: 120,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              // productDiscount == 0
                              //     ? Container()
                              //     : 
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.only(top: 20), 
                                      color: appColor,
                                      child: Text(
                                        '${store.state.offerProductList[index]['discount']}'"% off",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ))
                            ],
                          ),
                          Container(
                            /// color: Colors.red,
                            //padding: EdgeInsets.only(left: 15, right: 15),
                            width: MediaQuery.of(context).size.width / 2 - 35,
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                         
                                Container(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    store.state.offerProductList[index]['productName'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 8, left: 0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                              right: 0, top: 0, bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[ 
                                              Text(
                                                   store.state.offerProductList[index]['discountPrice'].toString()+" Tk",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      color: appColor,
                                                      fontWeight: FontWeight.bold)),
                                          
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                               
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   //color: Colors.red,
                  //   margin: EdgeInsets.only(top: 8, right: 8),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: <Widget>[
                  //       Container(
                  //           padding: EdgeInsets.all(6),
                  //           decoration: BoxDecoration(
                  //             color: widget.index % 2 == 0
                  //                 ? Color(0XFFFD68AE)
                  //                 : Colors.transparent,
                  //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  //           ),
                  //           child: Text(
                  //             widget.index % 2 == 0 ? "-80%" : "",
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 10,
                  //                 fontFamily: 'Roboto'),
                  //           )),
                  //     ],
                  //   ),
                  // )
                ],
              ),
          ),
        ),
      ),
                                                    ),
                                                    itemCount: store.state.offerProductList.length,
                                                  )),
          ],
        )),
            )),
      );
          }
    );
  }

  Container shopNow(String image) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            //margin: EdgeInsets.only(left: 15, right: 15),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: 180,
            ),
          ),
        ],
      ),
    );
  }
}
