import 'dart:io';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:pikemup/pages/host/host_create_trip_page.dart';

import '../../configurations/app_routes.dart';
import 'host_home_page.dart';
import '../../widgets/miscellaneous.dart';
import '../../../data/model/event.dart';
import '../../../data/constants/miscellaneous.dart';

class HostHomePageBottomBar extends StatefulWidget {
  HostHomePageBottomBar({super.key});

  @override
  State<HostHomePageBottomBar> createState() => _HostHomePageBottomBarState();
}

enum _SelectedTab { home, favorite, add, search, person }
class _HostHomePageBottomBarState extends State<HostHomePageBottomBar> {
  List<Widget> pages=[HostHomePage(),HostHomePage(),HostCreateTripPage(),HostHomePage(),HostHomePage()];
  File? selectedFile;
  int pageIndex=0;
  bool isLoading = false;
  bool uploaded = false;
  int i=0;
  // int page=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      // _selectedTab = _SelectedTab.values[i];
      pageIndex =i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
      extendBody: true,

      // backgroundColor: Color(0x00ffffff),
      // backgroundColor: Colors.black.withOpacity(0.2),
      // extendBodyBehindAppBar: true,
      // bottomNavigationBar: CurvedNavigationBar(
      //   // backgroundColor: appColors["primary"]!.shade700,
      //   backgroundColor: appColors["background"]!,
      //   color: appColors["primary"]!,
      //   index: pageIndex,
      //   // index: Get.find<HostController>().page.value,
      //   height: 65,
      //   animationDuration: const Duration(milliseconds: 400),
      //   items:  <Widget>[
      //     //
      //     // Padding(
      //     //   padding: const EdgeInsets.all(8.0),
      //     //   child: Column(
      //     //     mainAxisAlignment: MainAxisAlignment.center,
      //     //     children: [
      //     //       // Icon(Icons.home, size: 30,color:  appColors["white"]!),
      //     //       // Text("Home",style: TextStyle(color:  appColors["white"]!),),
      //     //       Icon(Icons.video_collection_outlined, size: 30,color: appColors["background"]!,),
      //     //       Text("Batches",style: TextStyle(color: appColors["background"]!),)
      //     //     ],
      //     //   ),
      //     // ),
      //
      //
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           // Icon(Icons.home, size: 30,color:  appColors["white"]!),
      //           // Text("Home",style: TextStyle(color:  appColors["white"]!),),
      //           Icon(Icons.home, size: 30,color: appColors["background"]!,),
      //           Text("Home",style: TextStyle(color: appColors["background"]!),)
      //         ],
      //       ),
      //     ),
      //
      //
      //
      //     // Padding(
      //     //   padding: const EdgeInsets.only(top:10.0),
      //     //   child: Column(
      //     //     mainAxisAlignment: MainAxisAlignment.center,
      //     //     children: [
      //     //
      //     //       Icon(Icons.document_scanner_outlined, size: 30,color: appColors["grey"]!,),
      //     //       Text("Bookings",style: TextStyle(color: appColors["grey"]!),)
      //     //     ],
      //     //   ),
      //     // ),
      //     // Padding(
      //     //   padding: const EdgeInsets.all(8.0),
      //     //   child: Column(
      //     //     mainAxisAlignment: MainAxisAlignment.center,
      //     //     children: [
      //     //       // Icon(Icons.person, size: 30,color:  appColors["white"]!),
      //     //       // Text("Profile",style: TextStyle(color:  appColors["white"]!),),
      //     //       Icon(Icons.person, size: 30,color: appColors["background"]!),
      //     //       Text("Profile",style: TextStyle(color: appColors["background"]!),)
      //     //     ],
      //     //   ),
      //     // ),
      //
      //     // Icon(Icons.search, size: 30),
      //     // Icon(Icons.airplane_ticket, size: 30),
      //   ],
      //   onTap: (index) {
      //     //openPage(page,index);
      //     pageIndex=index;
      //     setState(() {
      //
      //     });
      //   },
      // ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CrystalNavigationBar(
            // backgroundColor: Color(0x00ffffff),

          currentIndex: pageIndex,
          // indicatorColor: Colors.white,
          unselectedItemColor: Colors.white70,
          // backgroundColor: Colors.black.withOpacity(0.8),
          backgroundColor: appColors['black']!.withOpacity(0.4),
          // outlineBorderColor: Colors.black.withOpacity(0.1),
          onTap: _handleIndexChanged,
          items: [
          /// Home
          CrystalNavigationBarItem(
          icon: IconlyBold.home,
          unselectedIcon: IconlyLight.home,
          selectedColor: Colors.white,
          ),

          /// Favourite
          CrystalNavigationBarItem(
          icon: IconlyBold.heart,
          unselectedIcon: IconlyLight.heart,
          selectedColor: Colors.red,
          ),

          /// Add
          CrystalNavigationBarItem(
          icon: IconlyBold.plus,
          unselectedIcon: IconlyLight.plus,
          selectedColor: Colors.white,
          ),

          /// Search
          CrystalNavigationBarItem(
          icon: IconlyBold.search,
          unselectedIcon: IconlyLight.search,
          selectedColor: Colors.white),

          /// Profile
          CrystalNavigationBarItem(
          icon: IconlyBold.user2,
          unselectedIcon: IconlyLight.user2,
          selectedColor: Colors.white,
          ),
          ],
          ),
        ),
      ),


      body: Builder(builder: (context){
        return pages.elementAt(pageIndex);

      },
      ),
    );
  }

}
//
// void openPage(page,index)
// {
//   // var page = Get.find<HostController>().page.value;
//   switch(index){
//     case 0:
//       if(page!=0){
//         Get.toNamed(Routes.HOST_HOME);
//       }
//       // Get.toNamed(Routes.HOME);
//       break;
//     case 1:
//       if(page!=1){
//         Get.toNamed(Routes.HOST_CREATE_EVENT);
//       }
//       // Get.toNamed(Routes.SEARCH);
//       break;
//     case 2:
//       if(page!=2){
//         Get.toNamed(Routes.HOST_BOOKINGS);
//       }
//       // Get.toNamed(Routes.BOOKINGS);
//       break;
//     case 3:
//       if(page!=3){
//         Get.toNamed(Routes.HOST_PROFILE);
//       }
//       // Get.toNamed(Routes.BOOKINGS);
//       break;
//   }
// }

Widget eventListTile(Event event){
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListTile(
          tileColor: appColors["background"]!,
          splashColor: appColors["primary"]!,
          leading: CircleAvatar(
            radius: 40,
            backgroundColor: appColors["primary"]!,
            // backgroundImage: NetworkImage("https://clumsyapp.com"+event.thumbnail!,scale: 10),
          ),
          title: clumsyText(event.name,),
          subtitle: Row(
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month_rounded),
                  Text(event.eventTimestamp!)
                ],
              ),
              Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  Text(event.venue!)
                ],
              ),
            ],
          ),
          onTap: (){
            Get.to(Routes.HOST_EVENT,arguments: event.id);
          },
        ),
      ),
      Divider()
    ],
  );
}
