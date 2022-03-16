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

  bool loading=true,connecting=true,loadSocket=true,flag=false;
  late Socket socket;
  String loadText="Loading",senderId="";
  late SharedPreferences sharedPreferences;
  Chat chat=Chat();
  TextEditingController msg=TextEditingController(text: "");
  ScrollController scrollController=ScrollController();
  dynamic result=[],messages=[];

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

      socket.on('newMessage',(data) {
        print(data);
        flag=true;
        for(int i=0;i<result.length;i++){
          if(data["sender"]==result[i]["chatWithId"]){
            result[i]["datetime"]=data["dateTime"];
            result[i]["message"]=data["message"];
            flag=false;
          }
        }
        if(flag){
          result.add({"chatWith":data["chatWith"],"chatWithId":data["sender"],"message":data["message"],"datetime":data["dateTime"]});
        }
        setState(() {});
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

  void showChat({required String sender,required String senderName}){
    senderId=sender;
    loadSocket=true;
    print("hello");
    showModalBottomSheet(enableDrag: true,isScrollControlled: true,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))),context: context, builder: (BuildContext context){
      return WillPopScope(
        onWillPop: ()async{
          loading=true;
          loadChatList();
          return true;
        },
        child: StatefulBuilder(builder: (BuildContext context,setState)
        {
          if(loadSocket) {
            socket.on('newMessage', (data) {
              if (senderId == data["sender"]) {
                try {
                  setState(() {
                    messages.add(data);
                  });
                }catch(e){}
              }
              print(messages);
            });
            loadSocket=false;
          }
          return Container(
            decoration: BoxDecoration(
                color: Colors.blue[200]
            ),
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: GestureDetector(
              onDoubleTap: (){
                FocusScope.of(context).unfocus();
              },
              child: SizedBox.expand(
                child: Column(
                  children: [
                    Container(
                      height: 90,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blue
                      ),
                      padding: EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            loading=true;
                            loadChatList();
                            Navigator.pop(context);
                          }, icon: Icon(Icons.arrow_back),
                            color: Colors.white,),
                          SizedBox(width: 20,),
                          Text(senderName,style: TextStyle(fontSize: 20,color: Colors.white),)
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 19,
                        child: ListView.builder(
                          reverse: true,
                          controller: scrollController,
                          padding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
                          itemCount: messages.length,
                          itemBuilder: (context,index){
                            index=messages.length - 1 - index;
                            return Align(
                              alignment: messages[index]["sender"]!="You"?Alignment.centerLeft:Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: messages[index]["sender"]!="You"?Colors.blue[50]:Colors.white
                                ),
                                constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width*0.65
                                ),
                                margin: EdgeInsets.only(top: index!=0?messages[index-1]["sender"]==messages[index]["sender"]?5:12:12,),
                                child: Column(
                                  crossAxisAlignment: messages[index]["sender"]!="You"?CrossAxisAlignment.start:CrossAxisAlignment.end,
                                  children: [
                                    // index!=0?messages[index-1]["sender"]==messages[index]["sender"]?SizedBox():Padding(
                                    //   padding: const EdgeInsets.only(bottom: 5.0),
                                    //   child: Text(messages[index]["sender"],style: TextStyle(fontSize: 11),),
                                    // ):Padding(
                                    //   padding: const EdgeInsets.only(bottom: 5.0),
                                    //   child: Text(messages[index]["sender"],style: TextStyle(fontSize: 11),),
                                    // ),
                                    Padding(padding: messages[index]["sender"]=="You"?EdgeInsets.only(right: 5):EdgeInsets.only(left: 5),child: Text(messages[index]["message"],style: TextStyle(fontSize: 16),),),
                                    Padding(padding: EdgeInsets.only(top: 5),child: Text( DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(messages[index]["dateTime"])),style: TextStyle(fontSize: 11),),)
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                    ),
                    Container(
                      constraints: BoxConstraints(
                          minHeight: 50,
                          maxHeight: 80
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue[200]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex:5,
                              child: Padding(
                                padding: const EdgeInsets.only(left:5.0,right: 5),
                                child: Container(
                                  constraints: BoxConstraints(
                                      minHeight: 30,
                                      maxHeight: 80
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: TextField(
                                    controller: msg,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                        hintText: "Type Your Message",
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10)
                                    ),
                                    onChanged: (text){
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ),
                            msg.text.length==0?SizedBox():Expanded(
                                child: TextButton(
                                  child: Icon(Icons.send),
                                  onPressed: (){
                                    print("Send");
                                    setState(() {
                                      print(msg.text);
                                      messages.add({"sender":"You","message":msg.text,"dateTime":"${DateTime.now()}"});
                                      // Future.delayed(Duration(milliseconds: 20),(){
                                      //   scrollController.position.jumpTo(scrollController.position.maxScrollExtent);
                                      // });
                                    });
                                    socket.emit('sendMessage', {"sender":sharedPreferences.getString("mail"),"senderType":"coder","message":msg.text,"receiver":sender,"receiverType":"buyer"});
                                    msg.clear();
                                  },
                                  style: TextButton.styleFrom(backgroundColor: Colors.blue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),padding: EdgeInsets.all(12),primary: Colors.white),
                                )
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      );
    });
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
          onTap: ()async{
            messages=[];
            print(result[index]["chatWithId"]);
            var res=await chat.chatHistory(id: sharedPreferences.getString("mail"), chatWithId: result[index]["chatWithId"]);
            print(res);
            if(res!="error")
              messages=res;
            showChat(sender: result[index]["chatWithId"],senderName: result[index]["chatWith"]);
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
