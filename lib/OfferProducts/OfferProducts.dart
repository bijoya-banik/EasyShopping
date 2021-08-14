import 'package:Easy_Shopping/Card/ProductsCard/ProductsCard.dart';
import 'package:flutter/material.dart';
import 'package:Easy_Shopping/main.dart';
class OfferProducts extends StatefulWidget {
  @override
  _OfferProductsState createState() => _OfferProductsState();
}

class _OfferProductsState extends State<OfferProducts> {

    List offerList=[
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: appColor,
        titleSpacing: 0,
        title: Text("Offers"),
        automaticallyImplyLeading: true,
      ),

      body: GridView.builder(
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
                                              "user", store.state.offerProductList[index]),
                                        ),
                                        itemCount: store.state.offerProductList.length,
                                      ),
      
    );
  }
}