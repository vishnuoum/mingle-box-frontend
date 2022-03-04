import 'dart:convert';

import 'package:http/http.dart';

class Chat{
  Future<dynamic> chatList({required String? id})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.2:3000/coderChatList"),
          body: {"id": id});
      return jsonDecode(response.body);
    }
    catch(e){
      return "error";
    }
  }
}