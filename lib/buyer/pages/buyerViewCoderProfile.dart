import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mingle_box/buyer/services/service.dart';

class BuyerViewCoderProfile extends StatefulWidget {
  final Map arguments;
  const BuyerViewCoderProfile({Key? key,required this.arguments}) : super(key: key);

  @override
  State<BuyerViewCoderProfile> createState() => _BuyerViewCoderProfileState();
}

class _BuyerViewCoderProfileState extends State<BuyerViewCoderProfile> {

  dynamic result=[];
  bool loading=true;
  String loadText="Loading";
  Service service = Service();

  @override
  void initState() {
    loadCoderProfile();
    super.initState();
  }

  void loadCoderProfile()async{
    setState(() {});
    result = await service.viewCoderProfile(id: widget.arguments["id"]);
    if(result=="error" || result.length==0){
      Future.delayed(Duration(seconds: 5),(){
        setState(() {
          loadText="Something went wrong";
        });
        loadCoderProfile();
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
        title: Text("Coder Profile"),
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
      ):ListView(
        padding: EdgeInsets.all(15),
        children: [
          Text("Username",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text(result["username"],style: TextStyle(fontSize: 25),),
          SizedBox(height: 15,),
          Text("Mail",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text(result["mail"],style: TextStyle(fontSize: 25),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Unique ID",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
              TextButton.icon(label:Text("Copy ID"),
                onPressed: (){
                Clipboard.setData(ClipboardData(text: result["id"]));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Copied"),
                ));
              }, icon: Icon(Icons.copy),)
            ],
          ),
          SizedBox(height: 5,),
          Text(result["id"],style: TextStyle(fontSize: 17),),
          SizedBox(height: 15,),
          Text("Total Projects",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text(result["projects"].toString(),style: TextStyle(fontSize: 22),),
          SizedBox(height: 15,),
          Text("Completed Projects",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text(result["completed"].toString(),style: TextStyle(fontSize: 25),),
          SizedBox(height: 15,),
          Text("Technology",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text(result["technology"].substring(1,result["technology"].length-1).replaceAll("\"",""),style: TextStyle(fontSize: 25),),
        ],
      ),
    );
  }
}
