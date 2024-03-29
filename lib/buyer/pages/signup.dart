import 'package:flutter/material.dart';
import 'package:mingle_box/buyer/services/registration.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerSignup extends StatefulWidget {
  const BuyerSignup({Key? key}) : super(key: key);

  @override
  _BuyerSignupState createState() => _BuyerSignupState();
}

class _BuyerSignupState extends State<BuyerSignup> {

  late SharedPreferences sharedPreferences;

  BuyerRegistration registration=BuyerRegistration();

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  void load()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }

  TextEditingController eMail=TextEditingController(text: ""),password=TextEditingController(text: ""),
  name=TextEditingController(text: ""),repeatPassword=TextEditingController(text: ""),company=TextEditingController(text: "");

  String? dropValue="Select an option";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.only(top: 70,left: 30,right: 30),
            children: [
              Text("Buyer Signup",style: TextStyle(fontSize: 30,color: Colors.blue,fontWeight: FontWeight.bold),),
              SizedBox(height: 60,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: name,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Full name",
                    border: InputBorder.none,
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
                  controller: eMail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    border: InputBorder.none,
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
                  controller: company,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Company",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12,),
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
              //   decoration: BoxDecoration(
              //     color: Colors.blue[100],
              //     borderRadius: BorderRadius.circular(10)
              //   ),
              //   child: DropdownButton<String>(
              //     isExpanded: true,
              //     underline: SizedBox(),
              //     value: dropValue,
              //     items: <String>["Select an option","Coder", "Client"].map((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value,style: TextStyle(color: value=="Select an option"?Colors.grey[700]:Colors.black),),
              //       );
              //     }).toList(),
              //     onChanged: (val) {
              //       if(val!="Select an option") {
              //         setState(() {
              //           dropValue = val;
              //         });
              //       }
              //     },
              //   ),
              // ),
              // SizedBox(height: 12,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: password,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
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
                  controller: repeatPassword,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Repeat Password",
                      border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(height: 12,),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                child: Text("Signup",style: TextStyle(color: Colors.white,fontSize: 16),),
                onPressed: ()async{
                  FocusScope.of(context).unfocus();
                  if(eMail.text.length==0 || password.text.length==0 || company.text.length==0 ||repeatPassword.text.length==0||name.text.length==0){
                    alertDialog("Please complete the form");
                    return;
                  }
                  if(password.text!=repeatPassword.text){
                    alertDialog("Passwords doesn't match");
                    return;
                  }
                  if(password.text.length<8){
                    alertDialog("Password must be of at least 8 characters in length");
                    return;
                  }
                  if(!validateStructure(password.text)){
                    alertDialog("Password must be a combination of uppercase, lowercase and special characters (@,\$,!,#,&,* allowed)");
                    return;
                  }
                  showLoading(context);
                  dynamic result=await registration.signup(mail: eMail.text, username:name.text, company:company.text, password: password.text);
                  print(result);
                  if(result=="duplicate"){
                    Navigator.pop(context);
                    alertDialog("This mail id is already registered");
                  }
                  else if(result!="error"){
                    Navigator.pop(context);
                    sharedPreferences.setString("type", "buyer");
                    sharedPreferences.setString("mail", result["id"]);
                    OneSignal.shared.setExternalUserId(eMail.text);
                    Navigator.pushReplacementNamed(context, "/buyerHome");
                  }
                  else{
                    Navigator.pop(context);
                    alertDialog("Something went wrong. Try again later. Please check whether you are already registered.");
                  }
                },
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  child: Text("Already a User? Login!!!",style: TextStyle(color: Colors.blue),),
                  onTap: (){
                    Navigator.pushReplacementNamed(context, "/buyerLogin");
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
