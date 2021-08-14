
import 'package:Easy_Shopping/AllProducts/AllProducts.dart';
import 'package:Easy_Shopping/Cart/CartPage.dart';
import 'package:Easy_Shopping/DeliveredOrderList/DeliveredOrderList.dart';
import 'package:Easy_Shopping/HomePage/HomePage.dart';
import 'package:Easy_Shopping/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_Shopping/NotificationsScreen/NotificationsScreen.dart';
import 'package:Easy_Shopping/Profile/Profile.dart';
import 'package:Easy_Shopping/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
 

 var appToken;
 bool _fromTop = true;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {


      /// add firebase notification/////

    _firebaseMessaging.getToken().then((token) async {
      print("Notification app token");
      print(token);
      appToken = token;
     // _sendApptoken();
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        
        _showNotificationPop(
            message['notification']['title'], message['notification']['body']);
     
      },
      onLaunch: (Map<String, dynamic> message) async {
        pageLaunch(message);
      },
      onResume: (Map<String, dynamic> message) async {
        pageDirect(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    /// end firebase notification/////
    
    super.initState();

  }

    ///// handle looping onlaunch firebase //////
  void pageDirect(Map<String, dynamic> msg) {
    print("onResume: $msg");
    setState(() {
      index = 1;
    });
     Navigator.push( context, FadeRoute(page: DeliveryOrderList()));
  }

  void pageLaunch(Map<String, dynamic> msg) {
    print("onLaunch: $msg");
    pageRedirect();
  }

  void pageRedirect() {
    if (index != 1 && index != 2) {
       Navigator.push( context, FadeRoute(page: DeliveryOrderList()));
      setState(() {
        index = 2;
      });
    }
  }


  ///// end handle looping onlaunch firebase //////


  final List<Widget> children = [
  HomePage(),
  AllProducts(),
  CartPage(),
  Profile()

  ]; 

  int _currentIndex = bottomNavIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[_currentIndex],
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
           //  canvasColor: appColor,
              primaryColor: appColor,
              textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.grey)
              )
            ),
              child: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          currentIndex:
              _currentIndex, 
          items: [
           
            BottomNavigationBarItem(
              icon: Icon(Icons.home, ),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pages_sharp ),
              title: Text("Product"),
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined,),
              title: Text("Cart"),
            ), 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, ),
              title: Text("Account"),
            ),
           
          ],
        ),
      ),
    );
  }

  void onTabTapped(bottomNavIndex) {
    setState(() {
      _currentIndex = bottomNavIndex;
    });
  }

   void _showNotificationPop(String title, String msg) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (BuildContext context, anim1, anim2) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            // Navigator.push(context, SlideLeftRoute(page: NotificationPage()));
          },
          child: Material(
            type: MaterialType.transparency,
            child: Align(
              alignment:
                  _fromTop ? Alignment.topCenter : Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  bottomNavIndex = 4;
                   Navigator.push( context, FadeRoute(page: DeliveryOrderList()));
                },
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    //  final item = items[index];

                    return Dismissible(
                      key: Key("item"),
                      onDismissed: (direction) {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 80,
                        child: SizedBox.expand(
                            child: Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ////////////   Address  start ///////////

                              ///////////// Address   ////////////

                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                      left: 5, top: 2, bottom: 0),
                                  child: Text(title,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: appColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                      left: 5, top: 2, bottom: 8),
                                  child: Text(msg,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: appColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal))),
                            ],
                          ),
                        )),
                        margin: EdgeInsets.only(
                            top: 50, left: 12, right: 12, bottom: 50),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, _fromTop ? -1 : 1), end: Offset(0, 0))
                  .animate(anim1),
          child: child,
        );
      },
    );
  }
}
