import 'package:flutter/material.dart';

class MakePayment extends StatefulWidget {
  const MakePayment({Key? key}) : super(key: key);

  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {

  TextEditingController description=TextEditingController(text: ""),senderUID=TextEditingController(text: ""),cardNo=TextEditingController(text: ""),holderName=TextEditingController(text: ""),
      cvv=TextEditingController(text: ""), amount=TextEditingController(text: "");

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
            Text("Sender Unique ID"),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: senderUID,
                focusNode: null,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Sender Unique ID'
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
              if (amount.text.length == 0 || holderName.text.length==0 ||
                  cardNo.text.length == 0 || cvv.text.length==0 || senderUID.text.length==0 ||
                  description.text.length==0
              ) {}
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
