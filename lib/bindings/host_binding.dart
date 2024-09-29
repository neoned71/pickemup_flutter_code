import 'package:get/get.dart';

import '../controllers/authentication/authentication.dart';
import '../controllers/networking/networking.dart';

class HostBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<Authentication>( Authentication());
    Get.lazyPut<Networking>(() {return Networking();});
    // Get.lazyPut<StudentsController>(() {return StudentsController(); });
    // Get.lazyPut<FacultiesController>(() {return FacultiesController(); });
    // Get.lazyPut<RazorPayments>(() {return RazorPayments(); });
  }

}