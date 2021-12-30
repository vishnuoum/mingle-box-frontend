import 'dart:convert';

import 'package:http/http.dart';

class Service{

  Future<dynamic> loadDashboard({required String? id})async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.2:3000/buyerDashboard"),
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

  Future<dynamic> bidHistory({required String? id})async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.2:3000/buyerBidHistory"),
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

  Future<dynamic> projectList()async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.2:3000/projectList"));
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

  Future<dynamic> codersList({String query=""})async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.2:3000/codersList"),body: {"query":query});
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

  Future<dynamic> buyerProfile({required String? id})async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.2:3000/buyerProfile"),body: {"id":id});
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

  Future<dynamic> editProfile({required String username,required String company,required String? id})async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.2:3000/editBuyerProfile"),body: {"username":username,"company":company,"id":id});
      print(response.body);
      if (response.body == "error")
        return "error";
      else if(response.body == "done")
        return "done";
      else
        return "error";
    }
    catch(e){
      print(e);
      print("edit profile exception");
      return "error";
    }
  }

}