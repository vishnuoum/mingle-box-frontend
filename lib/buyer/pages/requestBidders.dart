import 'package:flutter/material.dart';
import 'package:mingle_box/buyer/services/service.dart';
import 'package:mingle_box/coder/services/project.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerRequestBidders extends StatefulWidget {
  final Object? arguments;
  const BuyerRequestBidders({Key? key,required this.arguments}) : super(key: key);

  @override
  State<BuyerRequestBidders> createState() => _BuyerRequestBiddersState();
}

class _BuyerRequestBiddersState extends State<BuyerRequestBidders> {

  dynamic result=[];

  bool loading=true;
  String loadText="Loading";
  Service service=Service();
  late Map arg;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    load();
    super.initState();
  }

  void load()async{
    sharedPreferences = await SharedPreferences.getInstance();
    loadBidders();
  }

  void loadBidders()async{
    setState(() {});
    arg=(widget.arguments as Map);
    result=await service.buyerRequestBidders(id: arg["id"]);
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

  Future<void> nonPopAlertDialog(var text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(child: AlertDialog(
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
                Navigator.of(context).pop();
              },
            ),
          ],
        ), onWillPop: ()async{
          return false;
        });
      },
    );
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: ()async{
                      print(result[index]);
                      showLoading(context);
                      var res= await service.buyerSelectBidder(id: sharedPreferences.getString("mail"), coderId: result[index]["bidderId"], requestId: arg["id"],amount: result[index]["amount"]);
                      if(res=="done"){
                        Navigator.pop(context);
                        nonPopAlertDialog("Bid completed successfully");
                      }
                      else{
                        Navigator.pop(context);
                        alertDialog("Something went wrong. Try again.");
                      }
                    }, child: Text("Select bidder"),style: TextButton.styleFrom(padding: EdgeInsets.all(10)),),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Bid Date : ${date.day}/${date.month}/${date.year}"),
                    )
                  ],
                )
              ],
            );
          }),
    );
  }
}
