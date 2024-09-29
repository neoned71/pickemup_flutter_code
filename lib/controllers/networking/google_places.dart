import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_place/google_place.dart';

class ClumsyGooglePlaces extends GetxController {
  late GooglePlace googlePlace;
  RxBool waiting = false.obs;
  // final RxList<AutocompletePrediction> predictions = (<AutocompletePrediction>[]).obs;
  final String _api_key='AIzaSyBRcYOxPK27t8A7e__RKubsCyGJssxDpFA';

  ClumsyGooglePlaces() {
    googlePlace = GooglePlace(_api_key);
  }

  Future<List<AutocompletePrediction>> autoCompleteSearch(String value) async {
    if(value.isEmpty){
      return [];
    }
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null)
    {
      if (kDebugMode) {
        print("successfully Grabbed Predictions");
      }

      return result.predictions!;

    }
    return [];
  }
}