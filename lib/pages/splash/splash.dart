
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rive/rive.dart';

import '../../../data/constants/miscellaneous.dart';

import '../../../data/model/user.dart';
import '../../configurations/app_routes.dart';
import '../../controllers/authentication/authentication.dart';
import '../../widgets/miscellaneous.dart';

class Splash extends StatefulWidget {

  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  late bool initialized=false;
  bool visibe = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 4),() async{
      await Get.find<Authentication>().initialize();
      if(Get.find<Authentication>().isLoggedIn.value)
        {
          print("found that logged in!");
          User u = Get.find<Authentication>().user!;
          print("found that role ${u.role}");
          print("initialized");
          if(u.role == "user")
            Get.offNamed(Routes.HOST_HOME);
          else if(u.role=="faculty")
            Get.offNamed(Routes.FACULTY_HOME);
          else
            Get.offNamed(Routes.LANDING_PAGE);
        }
      else{
        print("found that Logged Out");
        Get.offNamed(Routes.LOGIN);
      }
    });
    // _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Material(

      child:Container(
        decoration: BoxDecoration(
          color: appColors["background"]!
        ),
        alignment: Alignment.center,

        child: FadeIn(
            animate: true,
            duration: Duration(seconds: 2),

            child: FadeOut(
                animate: true,
                delay: Duration(seconds: 3),
                duration: Duration(seconds: 1),


                // Just change the Image.asset widget to anything you want to fade in/out:
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: clumsyTextLabel("Pick'emUp",fontsize: 40,color: appColors['text']),
                    ),
                    // AspectRatio(
                    //   aspectRatio: _controller.value.aspectRatio,
                    //   child: VideoPlayer(_controller),
                    // ),
                    // const Text("Clumsy",style: TextStyle(color: appColors["primary"]!,fontFamily: "Barokah",fontSize: 30),),
                  ],
                )

            ) // FadeOut
        ),
      )
    );
  }
}
