import 'dart:convert';

import 'package:http/http.dart';

class BuyersRequest{
  Future<dynamic> buyersRequest()async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.46:3000/listBuyersRequests"));
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      return "error";
    }
  }

  Future<dynamic> respond({required String? coderId,required String? requestId,required String amount})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.46:3000/coderRespond"),body: {"coderId":coderId,"requestId":requestId.toString(),"amount":amount});
      if(response.body=="done"){
        return "done";
      }
      return "error";
    }
    catch(e){
      print(e);
      return "error";
    }
  }

  Future<dynamic> responseHistory({required String? id})async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.46:3000/coderResponseHistory"),
          body: {"id": id});
      print(response.body);
      if (response.body == "error")
        return "error";
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      return "error";
    }
  }
}