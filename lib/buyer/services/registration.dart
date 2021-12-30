
import 'dart:convert';

import 'package:http/http.dart';

class BuyerRegistration{
  Future<dynamic> login({required String mail,required String password}) async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.2:3000/buyerValidate"), body: {"mail": mail, "password": password});
      print(response);
      if(response.body=="error")
        return "error";
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      return "error";
    }
  }

  Future<dynamic> signup({required String mail,required String password,required String username,required String company}) async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.2:3000/buyerRegister"), body: {"mail": mail, "username":username,"company":company,"password": password});
      print(response);
      if(response.body=="error")
        return "error";
      return jsonDecode(response.body);
    }
    catch(e){
      return "error";
    }
  }
}