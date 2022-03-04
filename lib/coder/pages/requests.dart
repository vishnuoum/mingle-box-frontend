import 'package:flutter/material.dart';
import 'package:mingle_box/coder/services/buyersRequest.dart';

class CoderRequests extends StatefulWidget {
  const CoderRequests({Key? key}) : super(key: key);

  @override
  _CoderRequestsState createState() => _CoderRequestsState();
}

class _CoderRequestsState extends State<CoderRequests> {

  dynamic result=[];
  BuyersRequest buyersRequest=BuyersRequest();
  bool loading=true;
  String loadText="Loading";

  @override
  void initState() {
    loadRequests();
    super.initState();
  }

  void loadRequests()async{
    setState(() {});
    result=await buyersRequest.buyersRequest();
    print(result);
    if(result=="error"){
      Future.delayed(Duration(seconds: 5),(){
        setState(() {
          loadText="Something went wrong";
        });
        loadRequests();
      });
    }
    else{
      setState(() {
        loading=false;
        loadText="Loading";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buyers' Requests"),
        elevation: 0,
      ),
      body: loading?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,width: 50,child: CircularProgressIndicator(strokeWidth: 5,valueColor: AlwaysStoppedAnimation(Colors.blue),),),
            SizedBox(height: 10,),
            Text(loadText)
          ],
        ),
      ):ListView.separated(
        padding: EdgeInsets.only(top: 5),
        itemCount: result.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              child: Text("${result[index]["username"][0].toUpperCase()}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            title: Text("${result[index]["name"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            subtitle: Text("${result[index]["username"]}",style: TextStyle(fontSize: 15),),
            trailing: IconButton(icon: Icon(Icons.chat),onPressed: (){

            },color: Colors.blue,),
            expandedAlignment: Alignment.topLeft,
            childrenPadding: EdgeInsets.all(10),
            children: [
              Text("Description",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(result[index]["description"])
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 0.5,
            height: 0,
            indent: 5,
            endIndent: 5,
          );
        },
      )
    );
  }
}
