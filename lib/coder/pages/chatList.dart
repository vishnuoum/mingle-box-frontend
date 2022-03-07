import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mingle_box/coder/services/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

dynamic result=[];

class CoderChatList extends StatefulWidget {
  const CoderChatList({Key? key}) : super(key: key);

  @override
  _CoderChatListState createState() => _CoderChatListState();
}

class _CoderChatListState extends State<CoderChatList> {

  bool loading=true,connecting=true;
  late Socket socket;
  String loadText="Loading";
  late SharedPreferences sharedPreferences;
  Chat chat=Chat();

  @override
  void initState() {
    load();
    super.initState();
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
        setState(() {
          connecting=false;
        });
        print('connected');
      });

      socket.emit('userId', {"userId":sharedPreferences.getString("mail")});
      
      socket.on('message',(data) {
        print(data);
      });
      socket.emit("connection");
    }catch(e){
      setState(() {
        loadText="Something went wrong";
      });
      print(e);
      Future.delayed(Duration(seconds: 5),(){
        init();
      });
    }
  }

  void load()async{
    sharedPreferences = await SharedPreferences.getInstance();
    loadChatList();
  }

  void loadChatList()async{
    setState(() {});
    result= await chat.chatList(id: sharedPreferences.getString("mail"));
    print(result);
    if(result=="error"){
      Future.delayed(Duration(seconds: 5),(){
        setState(() {
          loadText="Something went wrong";
        });
        loadChatList();
      });
    }
    else{
      setState(() {
        loading=false;
        loadText="Loading";
      });
    }
    init();
  }

  @override
  void dispose() {
    socket.emit("userDisconnection",{"userId":sharedPreferences.getString("mail")});
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        elevation: 0,
      ),
      body: loading&&connecting?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,width: 50,child: CircularProgressIndicator(strokeWidth: 5,valueColor: AlwaysStoppedAnimation(Colors.blue),),),
            SizedBox(height: 10,),
            Text(loadText)
          ],
        ),
      ):ListView.separated(separatorBuilder: (context, index) {return Divider(height: 0,indent: 5,endIndent: 5,);},itemCount: result.length,itemBuilder: (BuildContext context,int index){
        DateTime dateTime = DateTime.parse(result[index]["datetime"]);
        return ListTile(
          onTap: (){
            print(result[index]["chatWithId"]);
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            radius: 25,
            child: Text(result[index]["chatWith"][0].toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${result[index]["chatWith"]}",style: TextStyle(fontWeight: FontWeight.bold),),
              Text(DateFormat('dd/MM/yyyy').format(dateTime),style: TextStyle(fontSize: 14,color: Colors.grey[700]),)
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${result[index]["message"]}",overflow: TextOverflow.ellipsis,),
              Text(DateFormat('hh:mm a').format(dateTime))
            ],
          ),
        );
      }),
    );
  }
}
