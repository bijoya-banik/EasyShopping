import 'package:Easy_Shopping/SplashPage/splash.dart';
import 'package:Easy_Shopping/redux/reducer.dart';
import 'package:Easy_Shopping/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(MyApp());
}

final store = Store<AppState>(
  reducer,
  initialState: AppState(
  totalProduct: 0,
  totalCategory: 0,
  totalOrder: 0,

  categoryList: [],
  categoryLoading: true,

  productList: [],
  productLoading: true,

  availableProductList: [],
  availableProductLoading: true,

  emptyStockProductList: [],
  emptyStockProductLoading: true,

  offerProductList: [],
  offerProductLoading: true,

  searchProductList: [],

  orderList: [],
  orderLoading: true,
  
  )
);
int index = 0;
Color appColor = Color(0xFF0B6623);
Color black = Colors.black;
Color white = Colors.white;
Color grey = Colors.grey;
int bottomNavIndex=0;
var visit="";
var visitaddress="";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return StoreProvider<AppState>(
      store: store,                                      
      child: StoreConnector<AppState, AppState>(
          ////// this is the connector which mainly changes state/ui
          converter: (store) => store.state,
          builder: (context, items) {
            return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
        
          primarySwatch: Colors.green,
         
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      );
          }
      )
    );
  }
}
