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
            trailing: IconButton(icon: Icon(Icons.chat),onPressed: (){
              print(result[index]);
              socket.emit('sendMessage', {"sender":sharedPreferences.getString("mail"),"senderType":"coder","message":"Interested in ${result[index]["name"]}","receiver":result[index]["buyerId"],"receiverType":"buyer"});
              buyersRequest.respond(coderId: sharedPreferences.getString("mail"), requestId: result[index]["id"]);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("You responded for the request from ${result[index]["username"]}"),
              ));
              Navigator.pushNamed(context, "/coderChatList");
            },color: Colors.blue,),
            expandedAlignment: Alignment.bottomLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
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
