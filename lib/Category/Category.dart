import 'dart:convert';
import 'package:Easy_Shopping/CategoryProducts/CategoryProducts.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/api/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Easy_Shopping/main.dart';
class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
 
  // List category=[
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"fish",
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"shari",
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"fish",
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"shari",
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"fish",
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"shari",
  //   },
  // ];
  @override
  void initState() {
   // showCategory();
    super.initState();
  }

  // Future showCategory() async {
  //   var key = 'category-list';
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var localCategory = localStorage.getString(key);
  //   if (localCategory != null) {
  //     if (this.mounted) {
  //       setState(() {
  //         category = json.decode(localCategory);
  //       });
  //     }

  //     print(category);
  //   }
  // }

  Future<bool> _onWillPop() async {
   Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appColor,
         
          title: Text(
            'Category',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
         
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
           
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(top:25),
                  child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: store.state.categoryList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height - 320),
                      ),
                      itemBuilder: (context, int i) => GestureDetector(
                            onTap: () {
                              
                                Navigator.push(
                                    context,
                                    SlideLeftRoute(
                                        page: CategoryProducts(store.state.categoryList[i])));
                              
                            },
                            child: (Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: 8,
                                      left: 10,
                                    ),
                                    padding: EdgeInsets.all(4),
                                    height:
                                        MediaQuery.of(context).size.height / 11,
                                    width: MediaQuery.of(context).size.width / 6,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8.0)),
                                      border: Border.all(color: Colors.grey[350]),
                                      
                                    ),
                                    child:
                                    //  category[i]['cat_img'] == null ||
                                    //         category[i]['cat_img'] == ""
                                    //     ? Container()
                                    //     :
                                        //  Image.asset("images/placeholder.png"):
                                       Image.network(CallApi().getUrl()+store.state.categoryList[i]['categoryImage']),
                                        // CachedNetworkImage(
                                        //     imageUrl: category[i]['cat_img'],
                                        //     imageBuilder:
                                        //         (context, imageProvider) =>
                                        //             Container(
                                        //       decoration: BoxDecoration(
                                        //         image: DecorationImage(
                                        //           image: imageProvider,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     placeholder: (context, url) =>
                                        //         Container(), //CircularProgressIndicator(),
                                        //     errorWidget: (context, url, error) =>
                                        //         Icon(Icons.error),
                                        //   ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                        left: 15, right: 10, top: 6, bottom: 6),
                                    child: Text(
                                      store.state.categoryList[i]['categoryName'] == null
                                          ? ""
                                          : store.state.categoryList[i]['categoryName'],
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          )),
                )),
          ],
        )),
      ),
    );
  }
}
