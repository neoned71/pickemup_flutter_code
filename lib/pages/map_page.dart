

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late GoogleMapController _controller;
  Set<Marker> _markers = {};
  Location location = Location();
  Rx<LatLng> currentLocation = const LatLng(52.146973, 	-106.647034).obs;

  @override
  initState(){
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    var status = await location.requestPermission();
    if (status == PermissionStatus.granted) {
      startListeningLocation();
    } else {
      Get.snackbar( "Error","Location Permission Denied");
      // Permission denied, handle accordingly.
    }
  }

  StreamSubscription<LocationData>? locationSubscription;

  void startListeningLocation() {
    locationSubscription = location.onLocationChanged.listen((LocationData locationData) {
      // Handle location updates
      double latitude = locationData.latitude!;
      double longitude = locationData.longitude!;
      print(latitude);
      print(longitude);
      // ...
    });
  }

  void stopListeningLocation() {
    if (locationSubscription != null) {
      locationSubscription!.cancel();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Obx(
              ()=>
                GoogleMap(
                  buildingsEnabled: true,
                  mapToolbarEnabled: true,


                  markers: _markers,
                  onTap: _onMapTapped,
                  onMapCreated: (controller) {
                    setState(() {
                      _controller = controller;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: currentLocation.value, // San Francisco coordinates
                    zoom: 12.0,
                  ),
                ),

          ),
        // Positioned(
        //   top: 0,
        //   child: SizedBox(
        //
        //
        //       child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 2,sigmaY: 2),
        //         child: Container(
        //           color: Colors.transparent,
        //         ),)
        //   ),
        // )
        ]
      ),
    );
  }
  void _onMapTapped(LatLng location) {
    print("addming marker: "+location.toString());
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(location.toString()),
          position: location,
          onTap: (){

          },
          infoWindow: const InfoWindow(
            title: 'Marker Title',
            snippet: 'Marker Snippet',
          ),
        ),
      );
    });
  }

}