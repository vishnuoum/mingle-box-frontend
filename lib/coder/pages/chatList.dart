import 'package:flutter/material.dart';

class CoderChatList extends StatefulWidget {
  const CoderChatList({Key? key}) : super(key: key);

  @override
  _CoderChatListState createState() => _CoderChatListState();
}

class _CoderChatListState extends State<CoderChatList> {

  dynamic chatList=[
    {"id":"id","sender":"Sender","msg":"Last message","not read":"10","date":"27/20/2021"},
    {"id":"id","sender":"Sender","msg":"Last message","not read":"10","date":"27/20/2021"},
    {"id":"id","sender":"Sender","msg":"Last message","not read":"10","date":"27/20/2021"}
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        elevation: 0,
      ),
      body: ListView.separated(padding: EdgeInsets.symmetric(horizontal: 10),separatorBuilder: (context, index) {return Divider(height: 0,);},itemCount: chatList.length,itemBuilder: (BuildContext context,int index){
        return ListTile(
          onTap: (){},
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25,
            child: Text(chatList[index]["sender"][0].toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${chatList[index]["sender"]}",style: TextStyle(fontWeight: FontWeight.bold),),
              Text(chatList[index]["date"],style: TextStyle(fontSize: 14,color: Colors.grey[700]),)
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${chatList[index]["msg"]}",overflow: TextOverflow.ellipsis,),
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.blue,
                child: Text(chatList[index]["not read"],style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
              )
            ],
          ),
        );
      }),
    );
  }
}
