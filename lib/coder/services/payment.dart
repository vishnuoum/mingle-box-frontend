import 'dart:convert';

import 'package:http/http.dart';

class Payment{
  Future<dynamic> paymentHistory({required String? id})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.46:3000/coderPaymentHistory"),
          body: {"id": id});
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      return "error";
    }
  }
}