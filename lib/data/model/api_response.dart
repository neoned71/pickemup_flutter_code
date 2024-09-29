
import '../constants/miscellaneous.dart';

class APIResponse {
  late String status;
  late bool? hasData;
  late dynamic? data;
  late String? info;

  APIResponse({ required this.status,this.hasData,this.data,this.info});

  APIResponse.fromFailed({required this.info})
  {
    hasData=false;
    status=TextMessages.FAILED;
  }

  APIResponse.fromSuccess({this.hasData,this.data})
  {
    status=TextMessages.SUCCESS;
  }

}