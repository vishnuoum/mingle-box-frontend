import 'dart:convert';

import 'package:http/http.dart';

class Project{
  Future<dynamic> projectList({required String? id})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.46:3000/coderProjectList"),
          body: {"id": id});
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      return "error";
    }
  }

  Future<dynamic> addProject({required String? id,required String name,required String description,required String cost, required dynamic tech})async{
    print("add project");
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.46:3000/addCoderProject"),
          body: {"id": id,"name":name,"cost":cost,"description":description,"technology":jsonEncode(tech)});
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

  Future<dynamic> coderProjectBidders({required String? id})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.46:3000/coderProjectBidders"),
          body: {"id": id});
      print(response);
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      return "error";
    }
  }

  Future<dynamic> coderSelectBidder({required String? id,required String buyerId,required String projectId,required String amount})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.46:3000/coderSelectBidder"),
          body: {"id": id,"buyerId":buyerId,"projectId":projectId,"finalCost":amount});
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