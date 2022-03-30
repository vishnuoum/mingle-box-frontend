
import 'dart:convert';

import 'package:http/http.dart';

class CoderRegistration{
  Future<dynamic> login({required String mail,required String password}) async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.46:3000/coderValidate"), body: {"mail": mail, "password": password});
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
          Uri.parse("http://192.168.18.46:3000/coderRegister"), body: {"mail": mail, "password": password,"username":username});

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

  Future<dynamic> changePassword({required String id,required String oldPassword,required String newPassword}) async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.46:3000/coderPasswordReset"), body: {"id": id, "password": oldPassword,"newPassword":newPassword});
      print(response.body);
      if(response.body=="done")
        return "done";
      else
        return "error";
    }
    catch(e){
      print(e);
      return "error";
    }
  }
}