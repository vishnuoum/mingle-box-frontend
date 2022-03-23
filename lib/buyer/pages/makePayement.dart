import 'package:flutter/material.dart';
import 'package:mingle_box/buyer/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MakePayment extends StatefulWidget {
  const MakePayment({Key? key}) : super(key: key);

  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {

  TextEditingController description=TextEditingController(text: ""),receiverUID=TextEditingController(text: ""),cardNo=TextEditingController(text: ""),holderName=TextEditingController(text: ""),
      cvv=TextEditingController(text: ""), amount=TextEditingController(text: "");
  late SharedPreferences sharedPreferences;
  Service service = Service();

  @override
  void initState() {
    load();
    super.initState();
  }

  void load()async{
    sharedPreferences = await SharedPreferences.getInstance();
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.blue
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.only(left: 20, right: 20,top: 20,bottom: 20),
          children: [
            Align(child: Text("Payment", style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
                fontWeight: FontWeight.bold),),
              alignment: Alignment.centerLeft,),
            SizedBox(height: 40,),
            Text("Receiver Unique ID"),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: receiverUID,
                focusNode: null,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Receiver Unique ID'
                ),
              ),
            ),
            SizedBox(height: 15,),
            Text("Amount"),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: amount,
                focusNode: null,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Amount'
                ),
              ),
            ),
            SizedBox(height: 15,),
            Text("Card No."),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]
              ),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: cardNo,
                // textCapitalization: TextCapitalization.sentences,
                focusNode: null,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Card No.'
                ),
              ),
            ),
            SizedBox(height: 15,),
            Text("CVV"),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]
              ),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: cvv,
                focusNode: null,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'CVV'
                ),
              ),
            ),
            SizedBox(height: 15,),Text("Card Holder Name"),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: holderName,
                focusNode: null,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Card Holder Name'
                ),
              ),
            ),
            SizedBox(height: 15,),
            Text("Description"),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]
              ),
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.text,
                controller: description,
                focusNode: null,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Description'
                ),
              ),
            ),
            SizedBox(height: 15,),
            TextButton(onPressed: () async {
              FocusScope.of(context).unfocus();
              if (amount.text.length != 0 || holderName.text.length!=0 ||
                  cardNo.text.length != 0 || cvv.text.length!=0 || receiverUID.text.length!=0 ||
                  description.text.length!=0
              ) {
                showLoading(context);
                var result = await service.buyerPay(senderId: sharedPreferences.getString("mail"), receiverId: receiverUID.text, amount: amount.text, description: description.text);
                print(result);
                if(result=="done"){
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
                else{
                  Navigator.pop(context);
                  alertDialog("Payment failed. Try again");
                }
              }
              else{
                alertDialog("Please complete the form!!");
              }
            },
              child: Text("Make Payment", style: TextStyle(fontSize: 17),),
              style: TextButton.styleFrom(shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.blue,
                  primary: Colors.white,
                  padding: EdgeInsets.all(18)),),
            SizedBox(height: 15,),
            TextButton(onPressed: () {
              Navigator.pop(context);
            },
              child: Text("Cancel", style: TextStyle(fontSize: 17)),
              style: TextButton.styleFrom(padding: EdgeInsets.all(18)),)
          ],
        ),
      ),
    );
  }
}
