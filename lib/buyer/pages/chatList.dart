import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mingle_box/buyer/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerChatList extends StatefulWidget {
  const BuyerChatList({Key? key}) : super(key: key);

  @override
  _BuyerChatListState createState() => _BuyerChatListState();
}

class _BuyerChatListState extends State<BuyerChatList> {

  dynamic result=[];

  bool loading=true;
  String loadText="Loading";
  late SharedPreferences sharedPreferences;
  Service service=Service();

  @override
  void initState() {
    load();
    super.initState();
  }

  void load()async{
    sharedPreferences = await SharedPreferences.getInstance();
    loadChatList();
  }

  void loadChatList()async{
    setState(() {});
    result= await service.buyerChatList(id: sharedPreferences.getString("mail"));
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
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
      ):ListView.separated(separatorBuilder: (context, index) {return Divider(height: 0,indent: 5,endIndent: 5,);},itemCount: result.length,itemBuilder: (BuildContext context,int index){
        DateTime dateTime = DateTime.parse(result[index]["datetime"]);
        return ListTile(
          onTap: (){},
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
