

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/city_state.dart';

class TextMessages{
  static final String SUCCESS="success";
  static final String FAILED="failed";
  // static final String SOMETHINGS_WRONG="Something is just WRONG!";
}


class StorageKeys{
  static final String AUTH_KEY = "authentication";
  static final String TOKEN_KEY = "token";
  static final String USER_KEY = "user";
  static final String CART_STORAGE_KEY = "cart_storage";
  static final String CART_KEY = "cart";
}

class Credentials {
  static const String s3_poolD = "ap-south-1:9e3e34bc-b6cc-417d-b91e-05eb9a3677d5";
  static const String s3_bucketName = "clumsystorage";
}

String bucketBase = "https://clumsystorage.s3.ap-south-1.amazonaws.com";


List<CityState> cities = [
  CityState.defaultCity(),//all cities!
  CityState(city: "Bhopal", state: "Madhya Pradesh"),
];

class ModelData{
  late String url;
  late String name;
  ModelData({required this.url,required this.name});
}

// "symbol": "Li",
// "extract": "Lithium (from Greek: λίθος, translit. lithos, lit. 'stone') is a chemical element with symbol Li and atomic number 3. It is a soft, silvery-white alkali metal. Under standard conditions, it is the lightest metal and the lightest solid element.",
// "source": "https://en.wikipedia.org/wiki/Lithium",
// "category": "Alkali Metal",
// "atomic_weight": "6.94 u(±)",

class ElementInformation{
  late String name,symbol,extract,category,atomicWeight,number;
  ElementInformation({required this.name,required this.symbol,required this.atomicWeight,required this.category,required this.extract,required this.number});

  ElementInformation.fromJson(Map<String,dynamic> json){
    name = json["name"];
    number = json["number"].toString();
    symbol = json["symbol"];
    extract = json["extract"];
    category = json["category"];
    atomicWeight = json["atomic_weight"];

  }
}

List<ModelData> data = [
  ModelData(url:'https://embed.molview.org/v1/?mode=balls&&smiles=C([C@@H]1[C@H]([C@@H]([C@H](C(O1)O)O)O)O)O',name:"Glucose"),
  ModelData(url:'https://embed.molview.org/v1/?mode=balls&&smiles=OP(=O)(O)O',name:"Phosphoric acid"),
  ModelData(url:'https://embed.molview.org/v1/?mode=balls&&smiles=CC(=O)O ',name:"acetic acid"),
  ModelData(url:'https://embed.molview.org/v1/?mode=balls&&smiles=[N+](=O)(O)[O-]',name:"nitric acid"),
  ModelData(url:'https://embed.molview.org/v1/?mode=balls&&smiles=C([C@@H]1[C@H]([C@@H]([C@H]([C@H](O1)O[C@]2([C@H]([C@@H]([C@H](O2)CO)O)O)CO)O)O)O)O',name:"Sugar"),

  ModelData(url:'https://embed.molview.org/v1/?mode=balls&&smiles=C([H])1=C([H])C([H])=C([H])C([H])=C1[H]',name:"benzene ring"),
  // ModelData(url:'https://embed.molview.org/v1/?mode=balls&&smiles=[OH-].[OH-].[Ca+2]',name:"Calcium hydroxide"),
  ModelData(url:'https://embed.molview.org/v1/?mode=balls&&smiles=O',name:"Water(H20)"),

];

List<String> categories = [
  "-","EDM","Bollywood","HipHop","Ladies Night","Sit and Drink","Rock","Saturday night"
];

// const List<Color> appColors = [Colors.amber,Colors.white,Colors.black,Colors.grey,Colors.red,Colors.blue,Colors.green];
 Map<String,Color> appColors = {
  'secondary':Colors.purple.shade600,
  'primary':Colors.purpleAccent.shade700,
  'white':Colors.white,
  'background':Colors.white,
   'text':Colors.grey.shade800,
  "grey":Colors.grey,
  "red":Colors.red,
  "purple":Colors.purple,
  "black":Colors.black,
  "blue":Colors.blue,
  "green":Colors.green};


 openLink(String url) async{
  Uri uri = Uri.parse(url);
  if (!await launchUrl(uri,mode: LaunchMode.externalApplication)) {
    Get.snackbar("Error", "Could not open the link for the file");
  }
}
