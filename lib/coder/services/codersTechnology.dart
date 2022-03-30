import 'dart:convert';

import 'package:http/http.dart';

class CodersTechnology{
  Future<dynamic> getTechnologyList({required dynamic tech})async{
    try{
      Response response = await post(Uri.parse("http://192.168.18.46:3000/getCoderTechnologyList"));
      var result=[];
      dynamic techList=jsonDecode(response.body);
      techList.forEach((list){
        if(!tech.contains(list["technology"])){
          result.add(list);
        }
      });
      return result;
    }
    catch(e){
      print(e);
      return "error";
    }
  }
}