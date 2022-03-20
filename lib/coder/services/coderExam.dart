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

  Future<dynamic> coderExamSubmit({required dynamic answers,required String? id,required String technologyId})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.2:3000/coderExamSubmit"),
          body: {"answers": jsonEncode(answers), "id": id,"technologyId":technologyId});
      return jsonDecode(response.body);

    }
    catch(e){
      print(e);
      return "error";
    }
  }

  Future<dynamic> coderTechInfo({required String technology,required String? id})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.2:3000/coderTechInfo"),
          body: {"id": id,"technology":technology});
      print(response.body);
      return jsonDecode(response.body);

    }
    catch(e){
      print(e);
      return "error";
    }
  }
}