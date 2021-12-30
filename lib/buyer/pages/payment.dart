import 'package:flutter/material.dart';

class BuyerPayment extends StatefulWidget {
  const BuyerPayment({Key? key}) : super(key: key);

  @override
  _BuyerPaymentState createState() => _BuyerPaymentState();
}

class _BuyerPaymentState extends State<BuyerPayment> {

  TextEditingController cardNo=TextEditingController(text: ""),holderName=TextEditingController(text: ""),
                        cvv=TextEditingController(text: ""), amount=TextEditingController(text: "");

  dynamic history=[
    {"id":"132","amount":"1200","sender":"name","description":"Description Description Description Description"},
    {"id":"132","amount":"1200","sender":"name","description":"Description Description Description Description"}
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        elevation: 0,
      ),
      body: ListView.builder(itemCount: history.length,itemBuilder: (BuildContext context,int index){
        return ExpansionTile(
          leading: CircleAvatar(
            child: Text(history[index]["sender"][0].toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            backgroundColor: Colors.blue,
            radius: 25,
          ),
          title: Text("Rs.${history[index]["amount"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          subtitle: Text("Sender: ${history[index]["sender"]}",style: TextStyle(fontSize: 17),),
          children: [
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description:",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Text(history[index]["description"])
                ],
              ),
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("New Payment"),
        onPressed: (){
          showModalBottomSheet(enableDrag: true,isScrollControlled: true,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))),context: context, builder: (BuildContext context){
            return StatefulBuilder(builder: (BuildContext context,setState)
            {
              return Container(
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  children: [
                    SizedBox(height: 60,),
                    Align(child: Text("Edit Profile", style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),),
                      alignment: Alignment.centerLeft,),
                    SizedBox(height: 40,),
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
                    SizedBox(height: 15,),
                    Text("Card Holder Name"),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200]
                      ),
                      child: TextField(
                        keyboardType: TextInputType.phone,
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
                    TextButton(onPressed: () async {
                      if (amount.text.length != 0 && holderName.text.length!=0 &&
                          cardNo.text.length != 0 && cvv.text.length!=0) {}
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
              );
            });
          });
        },
      ),
    );
  }
}
