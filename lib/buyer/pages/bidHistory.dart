import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mingle_box/buyer/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerBidHistory extends StatefulWidget {
  const BuyerBidHistory({Key? key}) : super(key: key);

  @override
  _BuyerBidHistoryState createState() => _BuyerBidHistoryState();
}

class _BuyerBidHistoryState extends State<BuyerBidHistory> {

  bool loading=true;
  String text="Loading";

  late SharedPreferences sharedPreferences;
  Service service=Service();


  dynamic bidHistory=[{"id":"123","name":"name","projectId":"566","coder":"hello hai","amount":"1200","datetime":"27/02/2021","status":"pending"},
    {"id":"123","name":"name","projectId":"566","coder":"hello hai","amount":"1200","datetime":"27/02/2021","status":"pending"},
    {"id":"123","name":"name","projectId":"566","coder":"hello hai","amount":"1200","datetime":"27/02/2021","status":"pending"}
  ];

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
    bidHistory=await service.bidHistory(id: sharedPreferences.getString("mail"));
    if(bidHistory=="error"){
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Bid History"),
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
        ):ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: bidHistory.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: bidHistory[index]["status"]=="lost"?Colors.red:bidHistory[index]["status"]=="pending"?Colors.orange:Colors.green,
                  child: Icon(bidHistory[index]["status"]=="lost"?Icons.close:bidHistory[index]["status"]=="pending"?Icons.error:Icons.check,color: Colors.white,),
                ),
                title: Text("${bidHistory[index]["name"]}",style: TextStyle(fontSize: 17,),),
                subtitle: Text("Developer: ${bidHistory[index]["coder"]}"),
                children: [
                  ListTile(
                    title: Text("Status: ${bidHistory[index]["status"]}"),
                  ),
                  ListTile(
                    title: Text("Amount: Rs.${bidHistory[index]["amount"]}"),
                  ),
                  ListTile(
                    title: Text("Bid Date: ${bidHistory[index]["datetime"]}"),
                  )
                ],
              );
            }
        )
    );
  }
}
