import 'dart:convert';

import 'package:Easy_Shopping/Card/ProductsCard/ProductsCard.dart';
import 'package:Easy_Shopping/ErrorLogIn/ErrorLogIn.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/api/api.dart';
import 'package:flutter/material.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
class CategoryProducts extends StatefulWidget {

  final category;
  CategoryProducts(this.category);

  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {

List categoryProductList = [];
bool _isLoading = true;


    @override
  void initState() {
    bottomNavIndex = 0;

      _showCategory();

    super.initState();
  }

   Future<void> _showCategory() async {

     
    var res = await CallApi().getData('/api/showProductsByCategory/${widget.category['id']}');

    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      print(body);
setState(() {
  categoryProductList  = body['Product'];
});
    
      
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
    setState(() {
      _isLoading = false;
    });
  }

  //   List offerList=[
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":"500 Tk",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":"500 Tk",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":"500 Tk",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":"500 Tk",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":"500 Tk",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":"500 Tk",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":"500 Tk",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":"500 Tk",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":"500 Tk",
  //     'discount':10
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: appColor,
        titleSpacing: 0,
        title: Text(widget.category['categoryName']),
        automaticallyImplyLeading: true,
      ),

      body: 
     _isLoading
                                          ? Center(
                                              child: CircularProgressIndicator(),
                                            )
                                          : categoryProductList.length == 0
                                              ? Center(
                                                  child: Container(
                                                  margin: EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    "No Product is available"
                                                      ),
                                                ))
                                              :
      
      GridView.builder(
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
                                              "user", categoryProductList[index]),
                                        ),
                                        itemCount: categoryProductList.length,
                                      ),
      
    );
  }
}