import 'package:get/get.dart';
import '../controllers/authentication/authentication.dart';
import '../controllers/networking/networking.dart';

class RootBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<Authentication>( Authentication());
    Get.lazyPut<Networking>(() {return Networking();});
  }
}
