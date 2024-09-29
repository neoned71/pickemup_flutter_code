import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/constants/miscellaneous.dart';
import '../../data/model/user.dart';

class Authentication extends GetxController {
  RxBool isLoggedIn = false.obs;
  String? token;
  User? user;

  Authentication() {
    // initialize();
  }

  initialize() async {
    String token = GetStorage().read(StorageKeys.TOKEN_KEY)??"none";
    // showSnackbar("token", token);
    if (token != "none") {
      if (kDebugMode) {
        print("found that token was not null: $token");
      }
      String? user = GetStorage().read(StorageKeys.USER_KEY);
      if(user==null)
      {
        // print("found that user was null");
        await logout();

      }
      else{
        print("user json that was found in the store");
        print(user);
        // print("found that user was not null");
        User u = User.fromJson(jsonDecode(user));
        // print(u);
        await login(u);
        // print("found that logged in successfully");
      }
    }
    else{
      if (kDebugMode) {
        print("found that token was null");
      }
    }
  }
  login(User user) async
  {
    print("Performing : login()");
    try{
      token = user.token;
      await GetStorage().write(StorageKeys.TOKEN_KEY,token);
      await GetStorage().write(StorageKeys.USER_KEY,jsonEncode(user.toJson()));
      isLoggedIn.value = true;
      this.user = user;
    }catch(err)
    {
      print(err.toString());
    }
  }

  logout() async {
    print("Performing : logout()");
    try{
      token = null;
      await GetStorage().remove(StorageKeys.TOKEN_KEY);
      await GetStorage().remove(StorageKeys.USER_KEY);
      isLoggedIn.value = false;
      user = null;
    }catch(err)
    {
      print(err.toString());
    }
  }
}
