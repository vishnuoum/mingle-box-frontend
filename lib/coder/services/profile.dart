import 'dart:convert';

import 'package:http/http.dart';

class Profile{
  Future<dynamic> fetchProfile({required String? id})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.2:3000/coderProfile"),body: {"id":id});
      print(response.body);
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      return "error";
    }
  }

  Future<dynamic> editProfile({required String? id,required String username})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.2:3000/editCoderProfile"),body: {"id":id,"username":username});
      print(response.body);
      if(response.body=="done"){
        return "done";
      }
      else{
        return "error";
      }
    }
    catch(e){
      print(e);
      return "error";
    }
  }
}