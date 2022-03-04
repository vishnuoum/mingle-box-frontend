import 'package:flutter/material.dart';
import 'package:mingle_box/coder/services/project.dart';

class CoderProjectBidders extends StatefulWidget {
  final Object? arguments;
  const CoderProjectBidders({Key? key,required this.arguments}) : super(key: key);

  @override
  State<CoderProjectBidders> createState() => _CoderProjectBiddersState();
}

class _CoderProjectBiddersState extends State<CoderProjectBidders> {

  dynamic result=[];

  bool loading=true;
  String loadText="Loading";
  Project project=Project();

  @override
  void initState() {
    loadBidders();
    super.initState();
  }

  void loadBidders()async{
    setState(() {});
    Map arg=(widget.arguments as Map);
    result=await project.coderProjectBidders(id: arg["id"]);
    print(result);
    if(result=="error"){
      setState(() {
        loadText="Something went wrong";
      });
      Future.delayed(Duration(seconds: 5),(){
        loadBidders();
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
        title: Text("Project Bidders"),
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
      ):result.length==0?Center(child: Text("Nothing to display",style: TextStyle(color: Colors.grey[600],fontSize: 18),),):ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 1),
          itemCount: result.length,
          itemBuilder: (BuildContext context,int index){
            var date=DateTime.parse(result[index]["datetime"]);
            return ExpansionTile(
                expandedAlignment: Alignment.topLeft,
                leading: CircleAvatar(
                  child: Text(result[index]["bidder"][0].toUpperCase(),style: TextStyle(fontSize: 20),),
                  radius: 25,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                title: Text(result[index]["bidder"],style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("Rs. ${result[index]["amount"]}",style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold),),
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Bid Date : ${date.day}/${date.month}/${date.year}"),
                  )
                ],
            );
      }),
    );
  }
}
