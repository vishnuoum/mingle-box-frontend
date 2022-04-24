import 'package:flutter/material.dart';
import 'package:mingle_box/coder/services/buyersRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

class CoderRequests extends StatefulWidget {
  const CoderRequests({Key? key}) : super(key: key);

  @override
  _CoderRequestsState createState() => _CoderRequestsState();
}

class _CoderRequestsState extends State<CoderRequests> {

  TextEditingController name=TextEditingController(text: ""),amount=TextEditingController(text: "");

  dynamic result=[];
  BuyersRequest buyersRequest=BuyersRequest();
  late Socket socket;
  bool loading=true;
  String loadText="Loading";
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    load();
    super.initState();
  }

  void load()async{
    sharedPreferences=await SharedPreferences.getInstance();
    init();
  }

  void init()async{
    try {
      socket = io('http://192.168.18.2:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      // Connect to web socket
      socket.connect();
      socket.on('connect', (_){
        print('connected');
      });

      socket.emit('userId', {"userId":sharedPreferences.getString("mail")});

      socket.emit("connection");

    }catch(e){
      print(e);
      Future.delayed(Duration(seconds: 5),(){
        init();
      });
    }
    loadRequests();
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

  showBottomSheet({required String requestId,required String amt,required String requestName}){
    name.text=requestName;
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
              Text("Request (not editable)"),
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
                      hintText: 'Request name'
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
                if(double.parse(amount.text)>=double.parse(amt)){
                  alertDialog("You must provide an amount less than previous bid.");
                  return;
                }
                showLoading(context);
                var res=await buyersRequest.respond(coderId: sharedPreferences.getString("mail"),amount: amount.text,requestId: requestId);
                if(res=="done"){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  loading=true;
                  load();
                }
                else{
                  Navigator.pop(context);
                  alertDialog("Something went wrong. Try again later. Also check whether you are certified for these technologies.");
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
      ):result.length==0?Center(
        child: Text("Nothing to display",style: TextStyle(color: Colors.grey[600],fontSize: 17),),
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
            trailing: IconButton(icon: Icon(Icons.attach_money),onPressed: (){
              showBottomSheet(requestId: result[index]["id"], amt: result[index]["lowestBid"]=="0"?result[index]["cost"]:result[index]["lowestBid"], requestName: result[index]["name"]);
            },color: Colors.blue,),
            expandedAlignment: Alignment.bottomLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: EdgeInsets.all(10),
            children: [
              Text("Requested Technology",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(result[index]["technology"].substring(1,result[index]["technology"].length-1).replaceAll("\"","")),
              SizedBox(height: 10,),
              Text("Requested Cost",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("Rs.${result[index]["cost"]}"),
              SizedBox(height: 10,),
              Text("Description",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(result[index]["description"]),
              SizedBox(height: 10,),
              Text("Lowest Bid",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(result[index]["lowestBid"]=="0"?"None":"Rs.${result[index]["lowestBid"]}"),
              SizedBox(height: 10,),
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
