

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mingle_box/buyer/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerPayment extends StatefulWidget {
  const BuyerPayment({Key? key}) : super(key: key);

  @override
  _BuyerPaymentState createState() => _BuyerPaymentState();
}

class _BuyerPaymentState extends State<BuyerPayment> {


  bool loading=true;
  String text="Loading";
  Service service=Service();
  late SharedPreferences sharedPreferences;



  dynamic history=[
    {"id":"132","amount":"1200","sender":"name","description":"Description Description Description Description"},
    {"id":"132","amount":"1200","sender":"name","description":"Description Description Description Description"}
    ];

  @override
  void initState() {
    loadSP();
    super.initState();
  }

  void loadSP()async{
    sharedPreferences = await SharedPreferences.getInstance();
    load();
  }

  void load()async{
    setState(() {});
    history=await service.buyerPaymentHistory(id: sharedPreferences.getString("mail"));
    if(history=="error"){
      setState(() {
        text="Something went wrong";
      });
      Future.delayed(Duration(seconds: 5),(){load();});
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
        title: Text("Payment"),
        elevation: 0,
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
      ):history.length==0?Center(child: Text("Nothing to show"),):ListView.builder(itemCount: history.length,itemBuilder: (BuildContext context,int index){
        return ExpansionTile(
          leading: CircleAvatar(
            child: Text(history[index]["coder"][0].toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            backgroundColor: Colors.blue,
            radius: 25,
          ),
          title: Text("Rs.${history[index]["amount"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          subtitle: Text("To: ${history[index]["coder"]}",style: TextStyle(fontSize: 17),),
          children: [
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description:",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Text(history[index]["description"])
                ],
              ),
            ),
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment Date:",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(history[index]["datetime"])))
                ],
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("New Payment"),
        onPressed: ()async{
          await Navigator.pushNamed(context, "/makePayment");
          loading=true;
          load();
        },
      ),
    );
  }
}
