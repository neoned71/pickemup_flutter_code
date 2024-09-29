import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../widgets/miscellaneous.dart';

class TermsConditionsPage extends StatelessWidget {
  final String terms = "";
  const TermsConditionsPage({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appColors["background"]!,
      body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(

                // borderRadius: BorderRadius.all(Radius.circular(10)),
                color: appColors["background"]!
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height*0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Container(margin:EdgeInsets.all(10) ,child: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_circle_left_rounded,size: 40,color: appColors["primary"]!,))),
                  Container(margin:EdgeInsets.all(20) ,child: Text("Create Event", style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 32))),],
              ),
              Padding(padding: EdgeInsets.all(20), child: Text(terms),),
              ClumsyRealButton("Got It", Get.width, () { Get.back();}, false)

            ],
          )
        ),
      ),
    );
  }
}
