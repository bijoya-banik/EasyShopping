// import 'dart:async';
// import 'package:Easy_Shopping/CreateAddress/CreateAddress.dart';
// import 'package:Easy_Shopping/EditAddress/EditAddress.dart';
// import 'package:Easy_Shopping/main.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// // class ChooseLocation extends StatelessWidget {
// //   final id;
// //   final title;
// //   final house;
// //   final road;
// //   final area;
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Google Maps Demo',
// //       home: ChooseLocation(),
// //     );
// //   }
// // }

// class ChooseLocation extends StatefulWidget {
//   final id;
//   final title;
//   final house;
//   final road;
//   final area;

//   @override

//   ChooseLocation(this.id, this.title, this.house, this.road, this.area);
//   @override
//   _ChooseLocationState createState() => _ChooseLocationState();
// }

// class _ChooseLocationState extends State<ChooseLocation> {
//   var address1 = "Address1";
//   var address2 = "Swipe Map For select Address";
//   int btnColor = 0xFF808080;
//   var distanceKM = "";
//   double distance;
//   double zoomsize = 17.0;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
//   int _markerIdCounter = 0;
//   Completer<GoogleMapController> _mapController = Completer();

//   LatLng INITIAL_LOCATION = LatLng(24.491051, 91.774606);

//   void _onMapCreated(GoogleMapController controller) async {
//     _mapController.complete(controller);
//     if ([INITIAL_LOCATION] != null) {
//       MarkerId markerId = MarkerId(_markerIdVal());
//       LatLng position = INITIAL_LOCATION;
//       Marker marker = Marker(
//         markerId: markerId,
//         position: position,
//         draggable: false,
//       );
//     if (this.mounted){
//       setState(() {
//         _markers[markerId] = marker;
//       });
//     }

//       Future.delayed(Duration(seconds: 1), () async {
//         GoogleMapController controller = await _mapController.future;
//         controller.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: position,
//               zoom: zoomsize,
//             ),
//           ),
//         );
//       });
//     }
//   }

//   String _markerIdVal({bool increment = false}) {
//     String val = 'marker_id_$_markerIdCounter';
//     if (increment) _markerIdCounter++;
//     return val;    
//   }

//   getAddress(lat, lang) async {
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
//     address1 = first.featureName.toString();
//    if (this.mounted){
//       setState(() {
//       address2 = first.addressLine.toString();
//     });
//    }
//    }
   


//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           //appBar: AppBar(title: Text("Choose Location"),),
//           body: Column(
//         children: <Widget>[
//           Stack(
//             children: <Widget>[
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height - 140,
//                 child: GoogleMap(
//                   markers: Set<Marker>.of(_markers.values),
//                   onMapCreated: _onMapCreated,
//                   initialCameraPosition: CameraPosition(
//                     // target: Constants.LOCATION_SRI_LANKA,
//                     target: INITIAL_LOCATION,
//                     zoom: 12.0,
//                   ),
//                   myLocationEnabled: true,
//                   onCameraMove: (CameraPosition position) {
//                     if (_markers.length > 0) {
//                       MarkerId markerId = MarkerId(_markerIdVal());
//                       Marker marker = _markers[markerId];
//                       Marker updatedMarker = marker.copyWith(
//                         positionParam: position.target,
//                       );
// if (this.mounted){
//                       setState(() {
//                         _markers[markerId] = updatedMarker;
//                         print(updatedMarker.position.toString());

//                         // final harvesine = new Haversine.fromDegrees(
//                         //     latitude1: 24.486624,
//                         //     longitude1:  91.771832,
//                         //     latitude2: updatedMarker.position.latitude,
//                         //     longitude2: updatedMarker.position.longitude);

//                         // print(
//                         //     'Distance from location 1 to 2 is : ${harvesine.distance()}');
//                         // distance = harvesine.distance() / 1000;
//                         // distanceKM = distance.toStringAsFixed(2).toString();
//                         // if(distance<1.7){
//                           getAddress(updatedMarker.position.latitude,
//                               updatedMarker.position.longitude);
//                         //   btnColor=0xFF1741E5;
//                         // }
//                         // else if(distance>=1.7){
//                         //   address1 = "This Area is not Available for Delivery Food";
//                         //   btnColor = 0xFF808080;
//                         // }
//                       });
// }
//                     }
//                   },
//                 ),
//               ),

//             ],
//           ),
//           Container(
//             height: 1,
//             color: Colors.black,
//           ),
//           Container( 
//               color: Colors.white,
//               padding: EdgeInsets.all(5),
//               height: 89, 
//               width: double.infinity,
//               child: Text(
//                 address2 + "",
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           Container(
//             height: 50,
//             width: double.infinity,
//             child: RaisedButton(
//               color: Color(btnColor),
//               onPressed: () {


//                 if(visit=="add"){
//  Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => CreateAddress(address2,"1")));
//                 }
//                 else if(visit=="edit"){


//                   // print(widget.area);
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => EditAdress(widget.id, widget.title, widget.house,address2,widget.area)));
//                 }
              
               
//               },
//               textColor: Colors.white,
//               child:
//                   const Text('Confirm Address', style: TextStyle(fontSize: 14)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
