import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:rive/rive.dart' hide RadialGradient,LinearGradient;

import '../../api/api.dart';
import '../../configurations/app_routes.dart';
import '../../controllers/authentication/authentication.dart';
import '../../data/constants/miscellaneous.dart';
import '../../data/model/api_response.dart';
import '../../widgets/miscellaneous.dart';
class LoginPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> with TickerProviderStateMixin {
  late APIProvider ap;
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;
  TextEditingController phoneController = TextEditingController();
  String? phoneNumber;
  bool loginWait = false;
  bool agreed = true;

  @override
  void initState() {
    super.initState();
    Authentication authController = Get.find<Authentication>();
    if(authController.isLoggedIn.value )
      {
        if(authController.user!.role=="faculty"){
          Get.offAndToNamed(Routes.FACULTY_HOME);
        }
        else if(authController.user!.role=="user"){
          print("inside login trasnsition");
          Get.offAndToNamed(Routes.HOST_HOME);
        }
        else{
          Get.offAndToNamed(Routes.LANDING_PAGE);
        }
      }
    ap = APIProvider();

    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });

    controller2 = AnimationController(
      vsync: this,

      duration: const Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: 0.41, end: 0.81).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 40, end: 80).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.bounceIn,
      ),
    )..addListener(() {
      setState(() {});
    });

    Timer(const Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  Future<bool> attemptSendOtp(phone,signature) async{
    var response = await ap.requestOTP(phone, signature);
    if(response.status == TextMessages.SUCCESS)
      {
        String verificationId = response.data as String;
        Get.toNamed(Routes.OTP_VERIFICATION,arguments: verificationId);
        return true;
      }
    else
      {
        showSnackbar("Error", response.info!);
        return false;
      }
  }

  @override
  Widget build(BuildContext context)  {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:appColors["background"]!,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: Get.width,
                  height: Get.height,
                  // child: Image.asset("assets/images/glogo.png")
                  child: RiveAnimation.asset(
                    fit: BoxFit.fitHeight,
                    "assets/rive/flying_car.riv",
                    // artboard: "Emoji_package",

                  ),
                ),
              ),
              // Positioned(top:50,right: 20,
              //     child: InkWell(
              //
              //       onTap: (){
              //         Get.toNamed(Routes.FACULTY_LOGIN);
              //       },
              //       child: clumsyTextLabel("Faculty Login",
              //           color: appColors['primary']
              //       ),
              //     )
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [



                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          componentPhoneInput(Icons.phone, 'Phone...', true, false),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: clumsyTextLabel("Pick'emUp",fontsize: 40,color: appColors['white']),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: clumsyTextLabel("Car Rides at your preferred rates",fontsize: 15,color: appColors['white']),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(

                          ),
                          padding: const EdgeInsets.all(18.0),
                          child: CheckboxListTile(

                            // tileColor: appColors['grey'],
                            // subtitle: clumsyTextLabel("Please Read and Accept",color: Colors.black),
                            // subtitle: Text("Please Read and Accept"),
                            activeColor: appColors["primary"]!,
                            // isThreeLine: true,
                            // checkboxShape: RoundedRectangleBorder(side: BorderSide(color: appColors['green']!)),
                            checkColor: appColors["white"]!,
                            // tileColor: appColors["primary"]!,
                            title: clumsyTextLabel("I accept the Terms & Conditions",color: appColors['white']),
                            value: agreed,
                            // selectedTileColor: appColors["background"]!,
                            onChanged: (newValue) {
                              setState(() {
                                agreed = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          ),
                        ),
                      ),

                      Opacity(
                        opacity: 0.8,
                        child: ClumsyRealButton("Login", Get.width*0.8, () async {
                            HapticFeedback.lightImpact();
                            setState(() {
                              loginWait = true;
                            });
                            // await Future.delayed(const Duration(seconds: 2));
                            if(!agreed)
                              {
                                  showSnackbar("***", "Please Agree to the Terms and Conditions");
                              }
                            else
                              {
                                if(phoneController.text.length==10)
                                {

                                  String? sign = "pickemup-code";
                                  if(Platform.isAndroid){
                                    sign = await getSignature();
                                  }
                                  if(sign==null)
                                    {
                                      showSnackbar("Error","App signature is null");
                                      return;
                                    }
                                  print("sign:$sign");
                                  APIResponse res= await ap.requestOTP(phoneController.text.toString(), sign );
                                  if(res.status == TextMessages.SUCCESS)
                                  {
                                    showSnackbar("Requested OTP","Please do not press back",);
                                    Get.toNamed(Routes.OTP_VERIFICATION,arguments: {"verification_id":res.data,"signature":sign});
                                  }
                                  else{
                                    showSnackbar("Error", res.info!);
                                  }
                                }
                                else
                                {
                                  showSnackbar("***", "Please enter a valid phone number");
                                }
                              }

                            setState(() {
                              loginWait = false;
                            });

                          }
                            , loginWait),
                      ),
                      // component2(
                      //   'Login!',2, () async {
                      //     HapticFeedback.lightImpact();
                      //     // if(await )
                      //     setState(() {
                      //       loginWait = true;
                      //     });
                      //     await Future.delayed(const Duration(seconds: 2));
                      //     setState(() {
                      //       loginWait = false;
                      //     });
                      //     Get.toNamed(Routes.OTP_VERIFICATION);
                      //   },
                      //   loginWait
                      // ),
                      SizedBox(height: Get.height*0.01,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // InkWell(
                            //
                            //   onTap: (){
                            //     Get.toNamed(Routes.FACULTY_LOGIN);
                            //   },
                            //   child: clumsyTextLabel("Login",
                            //       color: appColors['secondary']
                            //   ),
                            // ),
                            Text("Terms And Condition",style:GoogleFonts.ubuntu(fontSize: 15,color:appColors["white"]!)),
                            // Text("Policy",style:GoogleFonts.acme(fontSize: 10)),

                            Text("About Us",style:GoogleFonts.ubuntu(fontSize: 15,color:appColors["white"]!)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 30,
          sigmaX: 30,
        ),
        child: Container(
          height: size.width / 8,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: appColors["white"]!.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            style: TextStyle(color: appColors["white"]!.withOpacity(.8)),
            cursorColor: appColors["white"]!,
            obscureText: isPassword,
            keyboardType:isEmail ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(

              prefixIcon: Icon(
                icon,
                color: appColors["white"]!.withOpacity(.2),
              ),
              // border: InputBorder(borderSide: BorderSide.),
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
              TextStyle(fontSize: 14, color: appColors["white"]!.withOpacity(0.7)),
            ),
          ),
        ),
      ),
    );
  }

  Widget componentPhoneInput(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    // Size size = MediaQuery.of(context).size;
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaY: 2,
        sigmaX: 2,
      ),
      child: Opacity(
        opacity: 0.8,
        child: Container(
          padding: EdgeInsets.all(10),
          // height: size.width / 8,
          width: Get.width / 1.2,
          alignment: Alignment.center,
          // padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(

            // border:  Border.all(color: appColors["text"]!,width: 2),
            // color: appColors["background"]!,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              // BoxShadow(color: appColors['grey']!,blurRadius: 5,offset: Offset(5,5)),
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IntlPhoneField(

              // validator: validateMobile ,
              cursorColor: appColors["grey"]!,
              controller: phoneController,


              // controller: phoneController,
              decoration: InputDecoration(

                counter: const Offstage(),
                labelText: 'Phone Number',

                labelStyle: GoogleFonts.ubuntu(color: appColors["white"]!,fontSize: 20),
                border: InputBorder.none
              ),

              initialCountryCode: 'CA',
              showCountryFlag: true,
              countries: const [Country(name: "Canada", flag: '🇨🇦', code: "CA", dialCode: "1", minLength: 10, maxLength: 10,nameTranslations: {'en':'Canada'}),],
              cursorWidth: 2,
              // pickerDialogStyle: PickerDialogStyle(countryCodeStyle:  GoogleFonts.ubuntu(fontSize: 20,color: appColors["white"]!),countryNameStyle:  GoogleFonts.ubuntu(fontSize: 20,color: appColors["white"]!)),
              dropdownTextStyle:GoogleFonts.ubuntu(fontSize: 30,color: appColors["white"]!) ,
              showDropdownIcon: false,
              style: GoogleFonts.ubuntu(fontSize: 20,color: appColors["white"]!),
              dropdownIconPosition:IconPosition.trailing,
              onChanged: (phone) {
                print("hello");
                print(phone.number);
                phoneNumber = phone.number;
              },
            ),
          ),
        ),
      ),
    );
  }
  FutureOr<String?> validateMobile(PhoneNumber value) async {
// Indian Mobile number are of 10 digit only
    if (value.completeNumber.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  Widget component2(String string, double width, VoidCallback voidCallback,bool showProgress) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: appColors["white"]!)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 0, sigmaX: 0),
          child: InkWell(

            // highlightColor: appColors["primary"]!,
            focusColor: appColors["white"]!,
            splashColor: appColors["primary"]!,

            onTap: showProgress?(){showSnackbar("Progress", "Request is being processed");}:voidCallback,
            child: Container(
              height: Get.width / 8,
              width: Get.width*0.8,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appColors["white"]!.withOpacity(.0),
                // borderRadius: BorderRadius.circular(15),
              ),
              child: showProgress?clumsyWaitingBar():Text(string,style: GoogleFonts.acme(fontSize: 20,color: appColors["white"]!),),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> getSignature() async {
    var _otpInteractor = OTPInteractor();
    var sign=await _otpInteractor.getAppSignature();
   return sign;
  }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..shader =  RadialGradient(colors: [appColors["primary"]!,appColors["background"]!],).createShader(
        Rect.fromCircle(
        center: Offset(0, 0),
        radius: radius,
      ));


    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

