import 'package:flutter/material.dart';
import 'package:mingle_box/buyer/services/registration.dart';

class BuyerPasswordReset extends StatefulWidget {
  final Map arguments;
  const BuyerPasswordReset({Key? key,required this.arguments}) : super(key: key);

  @override
  State<BuyerPasswordReset> createState() => _BuyerPasswordResetState();
}

class _BuyerPasswordResetState extends State<BuyerPasswordReset> {

  TextEditingController oldPassword=TextEditingController(text: ""),pass1=TextEditingController(text: ""),pass2=TextEditingController(text: "");
  BuyerRegistration buyerRegistration = BuyerRegistration();

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
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

  Future<void> alertSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(child: AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Password changed successfully."),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change password"),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20,left: 15,right: 15),
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextFormField(
              controller: oldPassword,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Old Password",
                  border: InputBorder.none
              ),
            ),
          ),
          SizedBox(height: 12,),
          Container(
            padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextFormField(
              controller: pass1,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "New Password",
                  border: InputBorder.none
              ),
            ),
          ),
          SizedBox(height: 12,),
          Container(
            padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextFormField(
              controller: pass2,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Repeat New Password",
                  border: InputBorder.none
              ),
            ),
          ),
          SizedBox(height: 20,),
          TextButton(
            onPressed: ()async{
              if(oldPassword.text.length==0 || pass1.text.length==0 || pass2.text.length==0){
                alertDialog("Please complete the form");
                return;
              }
              if(pass1.text!=pass2.text){
                alertDialog("Passwords doesn't match");
                return;
              }
              if(pass1.text==oldPassword.text){
                alertDialog("Please do not use one same as the old.");
                return;
              }
              if(pass1.text.length<8){
                alertDialog("Password must be of at least 8 characters in length");
                return;
              }
              if(!validateStructure(pass1.text)){
                alertDialog("Password must be a combination of uppercase, lowercase and special characters (@,\$,!,#,&,* allowed)");
                return;
              }
              showLoading(context);
              var res = await buyerRegistration.changePassword(id: widget.arguments["id"], oldPassword: oldPassword.text, newPassword: pass1.text);
              if(res=="done"){
                Navigator.pop(context);
                alertSuccessDialog();
              }
              else{
                Navigator.pop(context);
                alertDialog("Something went wrong. Try again later.");
              }
            },
            child: Text("Change",style: TextStyle(color: Colors.white,fontSize: 17),),
            style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.all(22),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            ),
          )
        ],
      ),
    );
  }
}