import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../data/constants/miscellaneous.dart';
import '../../widgets/miscellaneous.dart';

class SplashBoardingscreen  {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5),(){
      print("10 sec are up");
    });

    // ImageShader( Image.asset("assets/images/logo.png"), TileMode.clamp,TileMode.clamp,Matrix4.identity().storage);

    return Scaffold(
      body: Stack(

        alignment: Alignment.center,
        children:[
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: clumsyTextLabel("Pick'emUp",fontsize: 40,color: appColors['black']),
          ),
          // ShaderMask(
          //   shaderCallback: (bounds){
          //     return RadialGradient(
          //       center: Alignment.topLeft,
          //       radius: 1.0,
          //       colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
          //       tileMode: TileMode.mirror,
          //     ).createShader(bounds);
          //   },
          //   child: Image.asset("assets/images/logo.png",width: Get.width-10,),
          // ),
        ]
      ),
    );
  }
}
