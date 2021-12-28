import 'package:flutter/material.dart';

class BuyerProfile extends StatefulWidget {
  const BuyerProfile({Key? key}) : super(key: key);

  @override
  _BuyerProfileState createState() => _BuyerProfileState();
}

class _BuyerProfileState extends State<BuyerProfile> {

  dynamic result={
    "id":"id",
    "username":"name",
    "mail":"hello@gmail.com",
    "company":"company"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.blue
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20,left: 15,right: 15),
        children: [
          Text("Profile",style: TextStyle(color: Colors.blue,fontSize: 28,fontWeight: FontWeight.bold),),
          SizedBox(height: 30,),
          Text("Username",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Text("${result["username"]}",style: TextStyle(fontSize: 16),),
          SizedBox(height: 20,),
          Text("Company",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Text("${result["company"]}",style: TextStyle(fontSize: 16),),
          SizedBox(height: 20,),
          Text("Mail ID",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Text("${result["mail"]}",style: TextStyle(fontSize: 16),),
          SizedBox(height: 20,),
          Text("Unique ID",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Text("${result["id"]}",style: TextStyle(fontSize: 16),),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.edit),
      ),
    );
  }
}
