import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mingle_box/buyer/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerRequestHistory extends StatefulWidget {
  const BuyerRequestHistory({Key? key}) : super(key: key);

  @override
  _BuyerRequestHistoryState createState() => _BuyerRequestHistoryState();
}

class _BuyerRequestHistoryState extends State<BuyerRequestHistory> {

  dynamic requests=[{"id":"123","name":"Project Name","responses":"100","technology":["python","c"]},{"id":"123","name":"Project Name","responses":"100","technology":["python","c"]},{"id":"123","name":"Project Name","responses":"100","technology":["python","c"]}];
  bool loading=true;
  Service service=Service();
  String text="Loading";
  DateFormat format = DateFormat("dd/MM/yyyy");

  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    loadSP();
    super.initState();
  }

  void loadSP()async{
    sharedPreferences=await SharedPreferences.getInstance();
    load();
  }

  void load()async{
    setState(() {});
    requests=await service.buyerRequestHistory(id: sharedPreferences.getString("mail"));
    if(requests=="error"){
      setState(() {
        text="Something went wrong";
      });
      Future.delayed(Duration(seconds: 5),(){
        load();
      });
    }
    else{
      text="Loading";
      setState(() {
        loading=false;
      });
    }
    print(requests);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Request history"),
        ),
        body: loading?Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,width: 50,child: CircularProgressIndicator(strokeWidth: 5,valueColor: AlwaysStoppedAnimation(Colors.blue),),),
              SizedBox(height: 10,),
              Text(text)
            ],
          ),
        ):requests.length==0?Center(child: Text("Nothing to Show"),):ListView.builder(
            padding: const EdgeInsets.only(top: 10,bottom: 80,left: 10,right: 10),
            itemCount: requests.length,
            itemBuilder: (BuildContext context, int index) {
              if(requests[index]["technology"] is String)
                requests[index]["technology"]=json.decode(requests[index]["technology"]);
              return ExpansionTile(
                  title: Text(requests[index]["name"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  subtitle: Text("Requested cost: Rs.${requests[index]["cost"]}",style: TextStyle(fontSize: 15)),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Added Date:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        SizedBox(width: 10,),
                        Text(format.format( DateTime.parse(requests[index]["adddatetime"]))),],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Status:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        SizedBox(width: 10,),
                        Text(requests[index]["status"]),],
                    ),
                    SizedBox(height: 10,),
                    requests[index]["finalCost"]==null?SizedBox():Row(
                      children: [
                        Text("Completed Date:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        SizedBox(width: 10,),
                        Text(format.format( DateTime.parse(requests[index]["completeDate"]))),],
                    ),
                    SizedBox(height: 10,),
                    requests[index]["finalCost"]==null?SizedBox():Row(
                      children: [
                        Text("Final Cost:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        SizedBox(width: 10,),
                        Text(requests[index]["finalCost"]),],
                    ),
                    SizedBox(height: 10,),
                    Text("Requested Technologies:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: requests[index]["technology"].length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: Text(requests[index]["technology"][i]),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(height: 0,);
                      },
              ),],
                trailing: requests[index]["finalCost"]!=null?SizedBox():TextButton.icon(icon: Icon(Icons.person),onPressed: ()async{
                  await Navigator.pushNamed(context, "/buyerResponders",arguments: {"id":requests[index]["id"]});
                  loading=true;
                  load();
                },label: Text(requests[index]["responses"].toString()),),
              );
            }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await Navigator.pushNamed(context, "/buyerRequest");
          loading=true;
          load();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// GestureDetector(
// onTap: (){},
// child: Container(
// margin: EdgeInsets.only(bottom: 10),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// image: DecorationImage(
// image: AssetImage("assets/pic.jpg"),
// fit: BoxFit.cover,
// ),
// ),
// height: 220,
// padding: EdgeInsets.zero,
// child: Stack(
// children: [
// Positioned(
// bottom: 0,
// width: MediaQuery.of(context).size.width-20,
// child: Container(
// width: double.infinity,
// decoration: BoxDecoration(
// boxShadow: [BoxShadow(
// color: Colors.grey,
// blurRadius: 5.0,
// ),],
// borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
// color: Colors.white,
// ),
// padding: EdgeInsets.all(10),
// height: 90,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: Column(
// children: [
// Text("${requests[index]["name"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
// SizedBox(height: 3,),
// Text("No. of Responses: ${requests[index]["responses"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
// ],
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisSize: MainAxisSize.max,
// mainAxisAlignment: MainAxisAlignment.center,
// )
// ),
// ClipOval(
// child: Material(
// color: Colors.blue, // Button color
// child: InkWell(
// splashColor: Colors.blue[700], // Splash color
// focusColor: Colors.blue[700],
// hoverColor: Colors.blue[700],
// highlightColor: Colors.blue[700],
// onTap: () async{
// // await canLaunch("tel:${result[index]["phone"]}") ? await launch("tel:${result[index]["phone"]}") : throw 'Could not launch phone app';
// },
// child: SizedBox(width: 56, height: 56, child: Icon(Icons.person,color: Colors.white,)),
// ),
// ),
// )
// ],
// ),
// )
// )
// ],
// ),
// ),
// )




