import 'package:flutter/material.dart';

class CoderRequests extends StatefulWidget {
  const CoderRequests({Key? key}) : super(key: key);

  @override
  _CoderRequestsState createState() => _CoderRequestsState();
}

class _CoderRequestsState extends State<CoderRequests> {

  dynamic requests=[{"id":"id","project":"Hello","buyer":"Hai"},{"id":"id","project":"Hello","buyer":"Hai"}];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buyers' Requests"),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 5),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: (){},
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              child: Text("${requests[index]["project"][0]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            title: Text("${requests[index]["project"]}"),
            subtitle: Text("${requests[index]["buyer"]}"),
            trailing: IconButton(icon: Icon(Icons.chat),onPressed: (){},color: Colors.blue,),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 0.5,
            height: 0,
          );
        },
      )
    );
  }
}
