import 'dart:convert';

import 'package:http/http.dart';

class CoderExamClass{
  Future<dynamic> coderExamQuestions({required String technologyId})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.2:3000/coderExam"),
          body: {"technologyId": technologyId});
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      return "error";
    }
  }
}