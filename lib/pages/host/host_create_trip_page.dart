import 'dart:async';
import 'dart:convert';

import 'package:async_builder/async_builder.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:location/location.dart';
import 'package:pikemup/widgets/miscellaneous.dart';

import '../../configurations/app_routes.dart';
import '../../data/constants/miscellaneous.dart';

class HostCreateTripPage extends StatefulWidget{
  const HostCreateTripPage({super.key});
  @override
  State<HostCreateTripPage> createState() => _HostCreateTripPageState();
}

class _HostCreateTripPageState extends State<HostCreateTripPage> {

  late GoogleMapController _controller;
  TextEditingController startController=TextEditingController(text:"");
  Set<Marker> _markers = {};

  Location location = Location();

  Rx<LatLng> currentLocation = const LatLng(52.146973, 	-106.647034).obs;

  Rx<Marker> locationMarker=Marker(markerId: MarkerId("location"),).obs;
  @override
  initState(){
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // locationMarker.value= ;
    requestLocationPermission();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  }

  Future<void> requestLocationPermission() async {
    var status = await location.requestPermission();
    if (status == PermissionStatus.granted) {
      startListeningLocation();
    } else {
      Get.snackbar( "Error","Location Permission Denied");
    }
  }

  StreamSubscription<LocationData>? locationSubscription;

  void startListeningLocation() {
    locationSubscription = location.onLocationChanged.listen((LocationData locationData) {
      // Handle location updates
      double latitude = locationData.latitude!;
      double longitude = locationData.longitude!;
      print("inside lcoation tracker");
      locationMarker.value=Marker(
        markerId: MarkerId(location.toString()),
        position: LatLng(latitude,longitude),
        onTap: (){
          callDialog("Location", Text(""));
        },
        infoWindow: const InfoWindow(
          title: 'Marker Title',
          snippet: 'Marker Snippet',
        ),
      );
      print(latitude);
      print(longitude);
    });
  }

  void stopListeningLocation() {
    if (locationSubscription != null) {
      locationSubscription!.cancel();
    }
  }

  void detectLocation() async {
    print(":location");
    String cityState = await getUserCityState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: appColors["background"]!,
      child: Stack(
        children: [
          Obx(
                ()=>
                GoogleMap(
                  buildingsEnabled: true,
                  mapToolbarEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  // markers: _markers,
                  // ignore: unnecessary_null_comparison
                  // markers: {locationMarker.value},
                  // markers: locationMarker!=null?Set.from([..._markers,locationMarker]):_markers,
                  // onTap: _onMapTapped,
                  onTap: (latLng){},
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
          Positioned(top:50, child:SizedBox(
            width: Get.width,
            child: Center(
              child: Opacity(
                opacity: 1.0,
                child: Container(

                  margin: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                  decoration: BoxDecoration(
                      color: appColors['black'], borderRadius: BorderRadius.circular(0)),

                  // dropdown below..
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          splashColor: Colors.white,
                          onTap: (){
                            _controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation.value,zoom: 13)));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // clumsyTextLabel("Location"),
                              // Icon(Icons.my_location,color: appColors['primary'],)
                              Expanded(child: placesAutoCompleteTextField(),)
                            ],

                          ),
                        ),
                    )
                  ),
                ),
              ),
            ),
          ))
        ],
      )
    );
  }
  //
  // void detectLocation() async {
  //   print(":location");
  //   await getUserCityState();
  // }



  Widget getBody(List<Widget> lei)
  {


    return SafeArea(
      child: Scaffold(
        backgroundColor: appColors["background"]!,
        extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   elevation: 0.0,
        //   backgroundColor: Colors.transparent,
        //   actions: [
        //     Expanded(
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: appColors["primary"]!,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // headerBar("Home",parent: false),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: clumsyTextLabel("Welcome",fontsize: 30,color: appColors['grey']),
                        // ),
                        // IconButton(onPressed: (){}, icon: Icon(Icons.menu_sharp,color: appColors['primary']!,)),
                      ],
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(28.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         // color: appColors['grey'],
                  //         borderRadius: BorderRadius.circular(10),border:Border.all(color: Colors.green)),
                  //     width: Get.width,
                  //
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: clumsyTextLabel("Search",fontsize: 20,color: appColors['primary']),
                  //         ),
                  //         IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined,color: appColors['primary']!,)),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  // BookingPage(),
                  // MyBatches(),

                  // Center(child: clumsyTextLabel("Our Past Performance",color: appColors['primary'],fontsize: 20)),
                  Center(
                    // padding: const EdgeInsets.symmetric(vertical: 20.0),
                    // child: HomeCarousal(),
                    child: Image.asset('assets/images/glogo.png',height: 80,scale: 0.2,),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: clumsyTextLabel("Always know your elements",color: appColors['white'],fontsize: 20),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: CarouselSlider(
                  //       items: lei,
                  //       options: CarouselOptions(
                  //         height: 300,
                  //         aspectRatio: 16/9,
                  //         viewportFraction: 0.6,
                  //         initialPage: 0,
                  //         enableInfiniteScroll: true,
                  //         reverse: false,
                  //         autoPlay: true,
                  //         autoPlayInterval: Duration(seconds: 3),
                  //         autoPlayAnimationDuration: Duration(milliseconds: 800),
                  //         autoPlayCurve: Curves.fastOutSlowIn,
                  //         enlargeCenterPage: true,
                  //         enlargeFactor: 0.5,
                  //         onPageChanged: (a,b){
                  //           print(a);
                  //           print(b);
                  //         },
                  //         scrollDirection: Axis.horizontal,
                  //       )
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: clumsyTextLabel("Molecules 3D",color: appColors['white'],fontsize: 20),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: clumsyTextLabel("Artificial Intelligence",color: appColors['white'],fontsize: 20),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: appColors['grey']!,),
                      color: appColors['secondary'],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(

                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
                        elevation: 5,
                        child: ListTile(
                          onTap: (){
                            Get.toNamed(Routes.GRAVITY_AI_PAGE);
                          },
                          style: ListTileStyle.list,
                          // leading:
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
                          trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
                          // title:Image.asset('assets/images/glogo.png',height: 40,scale: 0.2,),
                          // subtitle: clumsyTextLabel("Personal AI Helper",color: appColors['primary']),
                          // leading: clumsyTextLabel("*"),
                          title: clumsyTextLabel("Q/A Intelligence",fontsize:18,color: appColors['primary']),
                          tileColor: appColors['black'],

                        ),
                      ),
                    ),
                  ),
                  // Divider(color:appColors['primary']),
                  // PreviousYearExamListWidget(),
                  // BatchListWidget(),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: clumsyTextLabel("Online Tests",fontsize: 20,color: appColors['primary']),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //   child: clumsyTextLabel("All Streams",fontsize: 14,color: appColors['grey']),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: AllEventsGrid(),
                  // ),
                ],
              ),
            ),
          ),
        ),
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

  placesAutoCompleteTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: startController,
        googleAPIKey:"AIzaSyA4hzbd66TmXNst4uDfdvHrlWso6FK12BI",
        inputDecoration: InputDecoration(
          hintText: "Search your location",
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),

        debounceTime: 400,
        countries: ["in", "fr"],
        isLatLngRequired: false,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          print("placeDetails" + prediction.lat.toString());
        },



        itemClick: (Prediction prediction) {
          startController.text = prediction.description ?? "";
          startController.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
        },
        seperatedBuilder: Divider(),
        // containerHorizontalPadding: 10,

        // OPTIONAL// If you want to customize list view item builder
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(
                  width: 7,
                ),
                Expanded(child: Text("${prediction.description??""}"))
              ],
            ),
          );
        },

        isCrossBtnShown: true,

        // default 600 ms ,
      ),
    );
  }
}

Widget _trendingList(String name) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: InkWell(
      splashColor: appColors["primary"]!,
      onTap: (){
        Get.toNamed(Routes.EVENT_TYPE_EVENTS,arguments: name);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 225,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color:appColors["primary"]!,style: BorderStyle.solid,width: 2),
              borderRadius: BorderRadius.circular(10),
              image:  DecorationImage(image:  AssetImage("assets/images/pager.jpg"),colorFilter: ColorFilter.mode(appColors["grey"]!, BlendMode.modulate), fit: BoxFit.cover)
          ),
          child: Center(
            child:Text(name,style: TextStyle(color: appColors["white"]!,fontFamily: "Barokah",fontSize: 12)),

          ),
          // child: Image.network("https://picsum.photos/125/100"),
        ),

      ),
    ),
  );






}
