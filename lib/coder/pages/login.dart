import 'package:flutter/material.dart';
import 'package:mingle_box/coder/services/registration.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoderLogin extends StatefulWidget {
  const CoderLogin({Key? key}) : super(key: key);

  @override
  _CoderLoginState createState() => _CoderLoginState();
}

class _CoderLoginState extends State<CoderLogin> {


  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    load();
    super.initState();
  }

  void load()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }

  TextEditingController eMail=TextEditingController(text: ""),password=TextEditingController(text: "");
  CoderRegistration registration = CoderRegistration();

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
              Text("Coder Login",style: TextStyle(fontSize: 30,color: Colors.blue,fontWeight: FontWeight.bold),),
              SizedBox(height: 60,),
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
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 16),),
                onPressed: ()async{
                  FocusScope.of(context).unfocus();
                  if(eMail.text.length==0 || password.text.length==0){
                    alertDialog("Please complete the form");
                    return;
                  }
                  showLoading(context);
                  dynamic result=await registration.login(mail: eMail.text, password: password.text);
                  print(result);
                  if(result=="wrong"){
                    Navigator.pop(context);
                    alertDialog("Wrong mail id or password");
                  }
                  else if(result!="error"){
                    Navigator.pop(context);
                    sharedPreferences.setString("type", "coder");
                    sharedPreferences.setString("mail", result["id"]);
                    OneSignal.shared.setExternalUserId(eMail.text);
                    Navigator.pushReplacementNamed(context, "/coderHome");
                  }
                  else{
                    Navigator.pop(context);
                    alertDialog("Something went wrong. Try again later");
                  }
                },
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  child: Text("New User? Signup!!!",style: TextStyle(color: Colors.blue),),
                  onTap: (){
                    Navigator.pushReplacementNamed(context, "/coderSignup");
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
