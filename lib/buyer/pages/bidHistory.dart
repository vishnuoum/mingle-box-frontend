import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyerBidHistory extends StatefulWidget {
  const BuyerBidHistory({Key? key}) : super(key: key);

  @override
  _BuyerBidHistoryState createState() => _BuyerBidHistoryState();
}

class _BuyerBidHistoryState extends State<BuyerBidHistory> {
  bool searchOn = false;
  bool search = false;
  TextEditingController searchController = TextEditingController(text: "");


  dynamic bidHistory=[{"id":"123","name":"name","projectId":"566","coder":"hello hai","amount":"1200","datetime":"27/02/2021","status":"pending"},
    {"id":"123","name":"name","projectId":"566","coder":"hello hai","amount":"1200","datetime":"27/02/2021","status":"pending"},
    {"id":"123","name":"name","projectId":"566","coder":"hello hai","amount":"1200","datetime":"27/02/2021","status":"pending"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Bid History"),
        ),
        body: search ? SizedBox() : ListView.builder(
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
                    title: Text("Status: Rs.${bidHistory[index]["status"]}"),
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
