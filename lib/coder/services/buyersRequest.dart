import 'dart:convert';

import 'package:http/http.dart';

class BuyersRequest{
  Future<dynamic> buyersRequest()async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.2:3000/listBuyersRequests"));
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      return "error";
    }
  }
}