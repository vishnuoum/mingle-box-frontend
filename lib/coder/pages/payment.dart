import 'package:flutter/material.dart';
import 'package:mingle_box/coder/services/payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoderPayment extends StatefulWidget {
  const CoderPayment({Key? key}) : super(key: key);

  @override
  _CoderPaymentState createState() => _CoderPaymentState();
}

class _CoderPaymentState extends State<CoderPayment> {

  TextEditingController cardNo=TextEditingController(text: ""),holderName=TextEditingController(text: ""),
                        cvv=TextEditingController(text: ""), amount=TextEditingController(text: "");

  dynamic result=[];

  bool loading=true;
  String loadText="Loading";
  late SharedPreferences sharedPreferences;
  Payment payment=Payment();

  @override
  void initState() {
    load();
    super.initState();
  }

  void load()async{
    sharedPreferences = await SharedPreferences.getInstance();
    loadPaymentHistory();
  }

  void loadPaymentHistory()async{
    setState(() {});
    result= await payment.paymentHistory(id: sharedPreferences.getString("mail"));
    print(result);
    if(result=="error"){
      Future.delayed(Duration(seconds: 5),(){
        setState(() {
          loadText="Something went wrong";
        });
        loadPaymentHistory();
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
        title: Text("Payments"),
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
      ):ListView.builder(itemCount: result.length,itemBuilder: (BuildContext context,int index){
        return ExpansionTile(
          leading: CircleAvatar(
            child: Text(result[index]["sender"][0].toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            backgroundColor: Colors.blue,
            radius: 25,
          ),
          title: Text("Rs.${result[index]["amount"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          subtitle: Text("Sender: ${result[index]["sender"]}",style: TextStyle(fontSize: 17),),
          children: [
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description:",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Text(result[index]["description"])
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
