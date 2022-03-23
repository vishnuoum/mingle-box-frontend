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

  Future<dynamic> buyerAddRequest({required String? id,required String name, required String description, required dynamic tech})async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.2:3000/addBuyerRequest"),body: {"id":id,"name":name,"description":description,"technology":jsonEncode(tech)});
      if(response.body=="done"){
        return "done";
      }
      else{
        return "error";
      }
    }
    catch(e){
      print(e);
      print("edit profile exception");
      return "error";
    }
  }

  Future<dynamic> buyerRequestHistory({required String? id})async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.2:3000/buyerRequestHistory"),body: {"id":id});
      print(response.body);
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      print("edit profile exception");
      return "error";
    }
  }

  Future<dynamic> buyerPay({required String? senderId,required String receiverId,required String amount,required String description})async{
    try {
      Response response = await post(Uri.parse("http://192.168.18.2:3000/buyerPay"),
          body: {
            "senderId": senderId,
            "receiverId": receiverId,
            "amount": amount,
            "description": description
          });
      if (response.body == "done") {
        return "done";
      }
      else {
        return "error";
      }
    }
    catch(e){
      print(e);
      return "error";
    }
  }

  Future<dynamic> buyerPaymentHistory({required String? id})async{
    try {
      dynamic response = await post(
          Uri.parse("http://192.168.18.2:3000/buyerPaymentHistory"),body: {"id":id});
      print(response.body);
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      print("edit profile exception");
      return "error";
    }
  }

  Future<dynamic> buyerChatList({required String? id})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.2:3000/buyerChatList"),
          body: {"id": id});
      return jsonDecode(response.body);
    }
    catch(e){
      return "error";
    }
  }

  Future<dynamic> buyerChatHistory({required String? id,required String chatWithId})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.2:3000/buyerChatHistory"),
          body: {"id": id,"chatWithId":chatWithId});
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
      return "error";
    }
  }

  Future<dynamic> buyerBid({required String? id,required String projectId,required String amount})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.2:3000/buyerBid"),
          body: {"id": id,"projectId":projectId,"amount":amount});
      if(response.body=="done"){
        return "done";
      }
      else{
        return "error";
      }
    }
    catch(e){
      return "error";
    }
  }

  Future<dynamic> buyerRequestResponders({required String? id})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.2:3000/buyerRequestResponders"),
          body: {"requestId": id,});
      return jsonDecode(response.body);
    }
    catch(e){
      return "error";
    }
  }

  Future<dynamic> viewCoderProfile({required String id})async{
    try {
      Response response = await post(
          Uri.parse("http://192.168.18.2:3000/viewCoderProfile"),
          body: {"id": id,});
      print(response.body);
      return jsonDecode(response.body);
    }
    catch(e){
      return "error";
    }
  }

}