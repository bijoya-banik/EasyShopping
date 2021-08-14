import 'dart:convert';

import 'package:Easy_Shopping/Navigation/Navigation.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/api/api.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetails extends StatefulWidget {

  final data;
  ProductDetails(this.data);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

   var counter = 1;
   List cartList = [];
   List cartProductList = [];
   var cartData;



   @override
  void initState() {
    getCart();
    super.initState();
  }


  getCart() async {
     SharedPreferences localStorage = await SharedPreferences.getInstance();
      var cartJson =  localStorage.getString('cart');
      if (cartJson != null) {
      var cart = json.decode(cartJson);
      //setState(() {
        cartData = cart;
        for (var d in cartData){
          cartList.add(d);
          cartProductList.add(d['productId']);
          print(cartList);
        }
       
    //  });
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: appColor,
         titleSpacing: 0,
        title:Text("Product")
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Stack(
            children: <Widget>[
          Container(
            height: 300,
            child: Container(
              padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.white,
                border: Border.all(width: 0.2, color: Colors.grey)),
            child: Image.network(
              CallApi().getUrl()+widget.data['productImage'],
              //'assets/images/logo.png',
              // height: 300,
              // width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
            )),

          
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20, top: 30),
                  padding: widget.data['discount'] == 0
                      ? EdgeInsets.only(
                          left: 0, right: 0, top: 0, bottom: 0)
                      : EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                  color: appColor,
                  child: Text(
                    widget.data['discount'] == 0
                        ? ""
                        : "${widget.data['discount']}% off",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
                ],
              ),
               
            ],
          )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left:10, right:10, top:20),
            child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[

                      widget.data['stock']==0?
                             Container(
                               alignment: Alignment.center,
                               child: Text(
                                 "Stock Out",
                                // widget.data.taxIncluded==null?"":'\$ ${widget.data.taxIncluded}',
                                 style: TextStyle(
                                     fontFamily: 'Poppins',
                                     fontSize: 20,
                                     color: Colors.redAccent,
                                     fontWeight: FontWeight.bold),
                               ),
                             ):Container(),
                      Container(
                        margin: EdgeInsets.only(top:20),
                        child: RichText(
                           text: TextSpan(
                               text: widget.data['productName']==null?"":widget.data['productName'],
                               style: TextStyle(
                                 fontFamily: 'Poppins',
                                 fontSize: 25,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.black87),
                              
                               ),
                        ),
                      ),
                    widget.data['stock']==0?Container():  Padding(
                       padding: EdgeInsets.only(top: 20, bottom: 40),
                       child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                            
                             Container(
                               height: 42,
                               width: 150,
                               decoration: BoxDecoration(
                                 border: Border.all(
                                     color: Color(0xFFD3D3D3), width: 2),
                                 borderRadius:
                                     BorderRadius.all(Radius.circular(13.0)),
                               ),
                               child: Padding(
                                 padding: EdgeInsets.only(left: 10, right: 10),
                                 child: Row(
                                   mainAxisAlignment:
                                       MainAxisAlignment.spaceEvenly,
                                   children: <Widget>[
                                     InkWell(
                                       onTap: () {
                                     setState(() {
                                           if (counter > 1) {
                                             counter--;
                                           }
                                         });

                                           
                                       },
                                       child: Text(
                                         "-",
                                         style: TextStyle(
                                             fontSize: 22,
                                             fontWeight: FontWeight.w600,
                                             fontFamily: 'Poppins'),
                                       ),
                                     ),
                                     Text(
                                       '$counter',
                                       style: TextStyle(
                                           fontSize: 15,
                                           fontWeight: FontWeight.w600,
                                           fontFamily: 'Poppins'),
                                     ),
                                     InkWell(
                                       onTap: () {
                                          setState(() {

                                            if(widget.data['stock']>counter){
                                               counter++;  
                                            }
                                            else{
                                              Fluttertoast.showToast(
                                              msg: "Stock out",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor:  Colors.redAccent.withOpacity(0.9),
                                              textColor: Colors.white,
                                              fontSize: 13.0);
                                            }
                                                  
                                                 });
                                     
                                       },
                                       child: Text(
                                         "+",
                                         style: TextStyle(
                                             fontSize: 22,
                                             fontWeight: FontWeight.w600,
                                             fontFamily: 'Poppins'),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                             Text(
                               widget.data['discount']==0?
                               widget.data['price'].toString()+" Tk":
                               widget.data['discountPrice'].toString()+" Tk",
                              
                               style: TextStyle(
                                   fontFamily: 'Poppins',
                                   fontSize: 25,
                                   fontWeight: FontWeight.bold),
                             )
                           ]),
                     ),


                         
                     //
                    
                     Row(
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.only(top:20),
                           child: Text(
                             "About the product",
                             style: TextStyle(
                                 fontFamily: 'Poppins',
                                 fontSize: 15,
                                 fontWeight: FontWeight.w600),
                           ),
                         )
                       ],
                     ),
                     //
                     Padding(
                       padding: EdgeInsets.only(top: 0),
                       child: Column(children: <Widget>[
                         Padding(
                           padding: EdgeInsets.only(top: 5, bottom: 18),
                           child: Text(
                           
                            widget.data['description']==null?"":widget.data['description'],
                             style: TextStyle(
                                 fontSize: 13,
                                 fontFamily: 'Poppins',
                                 color: Color(0xFF707070)),
                           ),
                         ),
                       ]),
                     ),




                     //
                     Padding(
                       padding: EdgeInsets.only(top: 20, bottom: 40),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           
                         widget.data['stock']==0?
                         Container():  Container(
                             height: 45,
                             width: (MediaQuery.of(context).size.width / 3) + 10,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(14.0),
                                 color: appColor),
                             child: RaisedButton(
                                 color: Colors.transparent,
                                 elevation: 0.0,
                                 highlightColor: Colors.transparent,
                                 highlightElevation: 0.0,
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(15.0),
                                 ),
                                 child: Text(
                                   "Add",
                                 // _isCart?_isLoading?"Adding...":"Already in cart \n Add more" :"Add to Cart",
                                  textAlign: TextAlign.center,
                                   style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 13,
                                       fontWeight: FontWeight.w600,
                                       fontFamily: 'Poppins'),
                                 ),
                                 onPressed: () {

                                   _addToCart();
                                  
                                 }),
                           ),
                           Container(
                             height: 45,
                             width: (MediaQuery.of(context).size.width / 3) + 10,
                             decoration: BoxDecoration(
                               border: Border.all(
                                   color: appColor, width: 1.5),
                               borderRadius:
                                   BorderRadius.all(Radius.circular(15.0)),
                             ),
                             child: RaisedButton(
                                 color: Colors.transparent,
                                 elevation: 0.0,
                                 highlightColor: Colors.transparent,
                                 highlightElevation: 0.0,
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(14.0),
                                 ),
                                 child: Text(
                                   "Cart",
                                   style: TextStyle(
                                       fontSize: 13,
                                       color: appColor,
                                       fontWeight: FontWeight.w600,
                                       fontFamily: 'Poppins'),
                                 ),
                                 onPressed: () {
                                   bottomNavIndex = 2;
                                   Navigator.push(context, FadeRoute(page: Navigation())); 
                                 }),
                           )
                         ],
                       ),
                     )
                   ],
                 ),
          )

         

              
                
              ],
            ),
          ),
        )),
      
    );
  }

   
     

   

  _addToCart() async {


      if(cartList.length>0){

        if(cartProductList.contains(widget.data['id'])){
          Fluttertoast.showToast(
          msg: "Already added this product to cart",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[700].withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 13.0);
        }
        else{
            cartProductList.add(widget.data['id']);
      cartList.add({
        "productId": widget.data['id'],
        "productImage": widget.data['productImage'],
        "productName":widget.data['productName'],
        "quantity":counter,
        "price":widget.data['discount']==0?widget.data['price']:widget.data['discountPrice'],
        "stock":widget.data['stock'],
      });

       Fluttertoast.showToast(
          msg: "Added to cart",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appColor.withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 13.0);
        }         
        
      }
      else{
      cartProductList.add(widget.data['id']);
      cartList.add({
        "productId": widget.data['id'],
        "productImage": widget.data['productImage'],
        "productName":widget.data['productName'],
        "quantity":counter,
        "price":widget.data['discount']==0?widget.data['price']:widget.data['discountPrice'],
        "stock":widget.data['stock'],
      });

       Fluttertoast.showToast(
          msg: "Added to cart",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appColor.withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 13.0);
      }

     

      print("cart");
      print(cartList);
      print(cartProductList);
       SharedPreferences localStorage = await SharedPreferences.getInstance();
       localStorage.setString('cart', json.encode(cartList));

  }
}