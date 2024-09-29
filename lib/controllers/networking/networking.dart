import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart' hide Response;
import '../../data/model/request_response.dart';
import 'package:dio/dio.dart';

import '../authentication/authentication.dart';

class Networking extends GetxController {
// all the apis reside here
late Authentication auth;
late Dio dio;

var options = BaseOptions(
  baseUrl: 'https://pickemup.blocksecai.org/api',
  // baseUrl: 'https://192.168.29.176:5000/api',
  connectTimeout: 50000,
  receiveTimeout: 600000,
);

  Networking(){
    dio = new Dio(options);
    auth = Get.find<Authentication>();
    print("networking initialized");
  }

  void healthCheck(){
    print("Logged In Status: "+auth.isLoggedIn.toString());
  }

  Future<RequestResponse> post(String path,{Map<String,dynamic>? headers,Map<String,dynamic>? query, dynamic data}) async
  {
    print(data);
    // print(path);
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return RequestResponse(code: -10, message: "Please Check Internet Connectivity", status: "failed");
    }
    try{
      Response<String> response = await dio.post(path,data:data,queryParameters: query,options:Options(headers: headers));
      if(response.statusCode ==200)
        {
            return RequestResponse.fromJson(json.decode(response.data!));
        }
      else if (response.statusCode ==400)
      {
        return RequestResponse(code: -10, message: "New faculties must be first registered with the institute.", status: "failed");
      }
      else
        {
          return RequestResponse(code: -10, message: response.statusCode.toString(), status: "failed");
        }
    }
    on DioError  catch (ex) {
      if(ex.type == DioErrorType.connectTimeout){
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    }
    catch(err)
    {
      print("Networking post method");
      return RequestResponse(code: -20, message: err.toString(), status: "failed");
    }
  }

Future<RequestResponse> get(String path,{Map<String,dynamic>? headers,Map<String,dynamic>? query}) async
{
  ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    return RequestResponse(code: -10, message: "Please Check Internet Connectivity", status: "failed");
  }
  try{
    Response<String> response = await dio.get(path,queryParameters: query,options:Options(headers: headers));
    print(path);
    print(response.data);
    if(response.statusCode ==200)
    {
      return RequestResponse.fromJson(json.decode(response.data!));
    }
    else
    {
      return RequestResponse(code: -10, message: response.statusCode.toString(), status: "failed");
    }
  }
  on DioError  catch (ex) {
    if(ex.type == DioErrorType.connectTimeout){
      throw Exception("Connection  Timeout Exception");
    }
    throw Exception(ex.message);
  }
  catch(err)
  {
    return RequestResponse(code: -20, message: err.toString(), status: "failed");
  }
}



}