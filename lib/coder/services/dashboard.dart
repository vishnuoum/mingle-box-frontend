import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard{
  
  Future<dynamic> fetch({required String? id})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.46:3000/coderDashboard"),body: {"id":id});
      print(response.body);
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      return "error";
    }
  }
}