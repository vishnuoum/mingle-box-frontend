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
  TextEditingController name=TextEditingController(text: ""),amount=TextEditingController(text: "");


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
    setState(() {});
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

  showLoading(BuildContext context){
    AlertDialog alert =AlertDialog(
      content: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,width: 50,child: CircularProgressIndicator(strokeWidth: 5,valueColor: AlwaysStoppedAnimation(Colors.blue),),),
            SizedBox(height: 10,),
            Text("Loading")
          ],
        ),
      ),
    );

    showDialog(context: context,builder:(BuildContext context){
      return WillPopScope(onWillPop: ()async => false,child: alert);
    });
  }

  Future<void> alertDialog(var text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showBottomSheet({required String projectId,required String amt,required String projectName}){
    name.text=projectName;
    amount.text=amt;
    showModalBottomSheet(enableDrag: true,isScrollControlled: true,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))),context: context, builder: (BuildContext context){
      return StatefulBuilder(builder: (BuildContext context,setState)
      {
        return Container(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            children: [
              SizedBox(height: 60,),
              Align(child: Text("Update Bid Amount", style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),),
                alignment: Alignment.centerLeft,),
              SizedBox(height: 40,),
              Text("Project (not editable)"),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]
                ),
                child: TextField(
                  enabled: false,
                  textCapitalization: TextCapitalization.words,
                  controller: name,
                  focusNode: null,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Project name'
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text("Amount"),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: amount,
                  // textCapitalization: TextCapitalization.sentences,
                  focusNode: null,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Amount'
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextButton(onPressed: () async {
                FocusScope.of(context).unfocus();
                if (name.text.length == 0 ||
                    amount.text.length == 0) {
                  alertDialog("Please complete the form!!");
                  return;
                }
                if(double.parse(amount.text)<=double.parse(amt)){
                  alertDialog("You must provide an amount greater than previous bid.");
                  return;
                }
                showLoading(context);
                var res=await service.buyerBid(id: sharedPreferences.getString("mail"),amount: amount.text,projectId: projectId);
                if(res=="done"){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  loading=true;
                  load();
                }
                else{
                  Navigator.pop(context);
                  alertDialog("Something went wrong. Try again later.");
                }
              },
                child: Text("Update", style: TextStyle(fontSize: 17),),
                style: TextButton.styleFrom(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.blue,
                    primary: Colors.white,
                    padding: EdgeInsets.all(18)),),
              SizedBox(height: 15,),
              TextButton(onPressed: () {
                Navigator.pop(context);
              },
                child: Text("Cancel", style: TextStyle(fontSize: 17)),
                style: TextButton.styleFrom(padding: EdgeInsets.all(18)),)
            ],
          ),
        );
      });
    });
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
                  backgroundColor: bidHistory[index]["status"]=="Lost"?Colors.red:bidHistory[index]["status"]=="Pending"?Colors.orange:Colors.green,
                  child: Icon(bidHistory[index]["status"]=="Lost"?Icons.close:bidHistory[index]["status"]=="Pending"?Icons.error:Icons.check,color: Colors.white,),
                ),
                title: Text("${bidHistory[index]["name"]}",style: TextStyle(fontSize: 17,),),
                subtitle: Text("Developer: ${bidHistory[index]["coder"]}"),
                children: [
                  ListTile(
                    title: Text("Status: ${bidHistory[index]["status"]}"),
                  ),
                  ListTile(
                    title: Text("Amount: Rs. ${bidHistory[index]["amount"]}"),
                    trailing: bidHistory[index]["status"]=="Pending"?TextButton(
                      child: Text("Change Amount"),
                      onPressed: (){
                        showBottomSheet(projectId: bidHistory[index]["projectId"], amt: bidHistory[index]["amount"], projectName: bidHistory[index]["name"]);
                      },
                    ):null,
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
