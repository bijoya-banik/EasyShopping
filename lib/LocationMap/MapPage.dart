
// import 'dart:async';

// import 'package:Easy_Shopping/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   //  SocketIOManager manager;
//   //  Map<String, SocketIO> sockets = {};
//   // Map<String, bool> _isProbablyConnected = {};

//   var addressName;

//   BitmapDescriptor pinIcon;
//   var pickLatitude;
//   var pickLongitude;
//   var body;
//   var addressData;
//   List allAddressData = [];
//   List deleteAddressList = [];
//   var homeAddressData;
//   var officeAddressData;
//   bool _isLoading = true;
//   bool _fromTop = true;
//   var currentLatitude;
//   var currentLongitude;
//   var homeAddress;
//   var officeAddress;
//   var address;
//   var locData;
//   int unseenNotific = 12;
//   var count;
//   bool _notificLoading = true;
//   var notificCount;

//   int showNumber = 0;

//   ///////////// Google Map //////////
//   Set<Marker> _markers = Set();
//   Set<Polyline> _polylines = Set();
//   CameraPosition _initialPosition;
//   Completer<GoogleMapController> _controller = Completer();


//   void _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//   }



//   bool _isLoadingUser = true;
//   var userData;
//   var name = "";
//   var phone = "";
//   var countryCode = "";
//   var address2 = "";


//   //////////////// get address end ///////////////
//   @override
//   void initState() {
//     //  manager = SocketIOManager();
// print("data");
//     _deviceLocation();
   
//     // _showAlertDialog();
//     _initialPosition =
//         CameraPosition(target: LatLng(24.8319, 92.0825), zoom: 15);

       
//     super.initState();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         //automaticallyImplyLeading: false,
//         iconTheme: IconThemeData(color: Colors.white),
//         backgroundColor: appColor,
//         titleSpacing: 0,
//         elevation: 0,
//         title: Text("Choose your location"),
//       ),
     
//       body: Container(
       
//         child: Stack(
//           children: <Widget>[
//             //////////////////////// Map & Text part start///////////////////
//             Container(
//               child: Column(

//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
               

//                   ////////////// Map Start /////////////////

//                   Expanded(
//                                       child: Container(
//                       width: MediaQuery.of(context).size.width,
//                 //height: MediaQuery.of(context).size.height/2,
//                       child: GoogleMap(
//                     markers: _markers,
//                     polylines: _polylines,
//                     mapType: MapType.normal,
//                     myLocationEnabled: true,
//                     myLocationButtonEnabled: true,
//                     onMapCreated: _onMapCreated,
//                     initialCameraPosition: _initialPosition,
//                      onCameraMove: ((_position) => _updatePosition(_position)),
//                       ),
//                     ),
//                   ),

//                   ////////////// Map End /////////////////
//                   Column(
//                     children: [
//                       Container(
//             height: 1,
//             color: Colors.black,
//           ),
//               Container( 
//               color: Colors.white,
//               padding: EdgeInsets.all(5),
//               height: 89, 
//               width: double.infinity,
//               child: Text(
//                 address2 + "",
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             Container(
//                 height: 50,
//                 width: double.infinity,
//                 child: RaisedButton(
//                   color: appColor,
//                   onPressed: () {


// //                 if(visit=="add"){
// //  Navigator.push(context,
// //                     MaterialPageRoute(builder: (context) => CreateAddress(address2,"1")));
// //                 }
// //                 else if(visit=="edit"){


// //                   // print(widget.area);
// //                 Navigator.push(context,
// //                     MaterialPageRoute(builder: (context) => EditAdress(widget.id, widget.title, widget.house,address2,widget.area)));
// //                 }
                  
                   
//                   },
//                   textColor: Colors.white,
//                   child:
//                       const Text('Confirm Address', style: TextStyle(fontSize: 14)),
//                 ),
//               )
//                     ],
//                   ),
      
          
//                 ],
//               ),
//             ),
//             //////////////////////// Map & Text part end///////////////////

          
//           ],
//         ),
//       ),
   
//     );
//   }



//   ///////////// Current Location Picker//////////
//   void _deviceLocation() async {

//     print("objectcur");
//     LocationData currentLocation;
//     var location = Location();
//     try {
//       currentLocation = await location.getLocation();
//     } on Exception {
//       currentLocation = null;
//     }

//      currentLatitude = currentLocation.latitude;
//     currentLongitude = currentLocation.longitude;


//     GoogleMapController controller = await _controller.future;
//     controller.moveCamera(CameraUpdate.newCameraPosition(
//       CameraPosition(
//         target: LatLng(currentLatitude, currentLongitude),
//         zoom: 15.0,
//       ),
//     ));

//     setState(() {
//       print(currentLatitude);
//       print(currentLongitude);
//       _markers.add(
//         Marker( 
//           icon: pinIcon,
//           markerId: MarkerId('pickLocationId'),
//           position: LatLng(currentLatitude, currentLongitude),
//         ),
//       );
//     });

   

//     var loc = {"lat": currentLatitude, "long": currentLongitude};

//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     localStorage.setString('locationStatus', "on");
//     localStorage.setString('currentLoc', json.encode(loc));
//     // _getLocationInfo();
//   }



//   void _updatePosition(CameraPosition _position) async {
//     print("object");
//     Marker marker = _markers.firstWhere(
//         (p) => p.markerId == MarkerId('marker_2'),
//         orElse: () => null);
//     setState(() {
//       _markers.remove(marker);
//     });

//     _markers.add(
//       Marker(
//         markerId: MarkerId('marker_2'),
//         //   icon: texiIcon,
//         position: LatLng(_position.target.latitude, _position.target.longitude),

//         // infoWindow: myAddress != ''
//         //     ? InfoWindow(title: "$myAddress")
//         //     : InfoWindow(
//         //         title: '${_position.target.latitude}',
//         //         snippet: '${_position.target.longitude}'),
//         // infoWindow: InfoWindow(title: '${_position.target.latitude}',
//         //         snippet: '${_position.target.longitude}'),
//         draggable: true,
//         //icon: _searchMarkerIcon,
//       ),
//     );

//     setState(() {
//       pickLatitude = _position.target.latitude;
//       pickLongitude = _position.target.longitude;
//     });

//     print(_position.target.latitude);

//     print("lat: " +
//         pickLatitude.toString() +
//         "     long: " +
//         pickLongitude.toString());
      
//      getAddress(pickLatitude, pickLongitude);
//   }


//     getAddress(lat, lang) async {
//     final coordinates = new Coordinates(lat, lang);
//     var addresses =
//   //  await Geocoder.google("AIzaSyAiXNjJ3WpC-U-NKUPY66eQK471y1CiWTY").findAddressesFromCoordinates(coordinates);
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);

    
//        print(addresses);
//    if(addresses.length==0){

//    }
//    else{
//     var first = addresses.first;
//    print("${first.featureName} : ${first.addressLine}");
//   print("1");
//   print("${first.featureName}");
//   print("2");
//   print("${first.addressLine}");
//   //   address1 = first.featureName.toString();
//    if (this.mounted){
//       setState(() {
//       address2 = first.addressLine.toString();
//     });
//    }
//    }
   


//   }

//   ///////// show all address////

// }
