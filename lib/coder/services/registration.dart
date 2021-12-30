
import 'dart:convert';

import 'package:http/http.dart';

class CoderRegistration{
  Future<dynamic> login({required String mail,required String password}) async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.2:3000/coderValidate"), body: {"mail": mail, "password": password});
      print(response.body);
      if(response.body=="error")
        return "error";
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      return "error";
    }
  }

  Future<dynamic> signup({required String mail,required String password,required String username}) async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.2:3000/coderRegister"), body: {"mail": mail, "password": password,"username":username});

      print(response.body);
      if(response.body=="error")
        return "error";
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      return "error";
    }
  }
}