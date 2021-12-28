import 'package:flutter/material.dart';

class BuyerLogin extends StatefulWidget {
  const BuyerLogin({Key? key}) : super(key: key);

  @override
  _BuyerLoginState createState() => _BuyerLoginState();
}

class _BuyerLoginState extends State<BuyerLogin> {

  TextEditingController eMail=TextEditingController(text: ""),password=TextEditingController(text: "");

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
              Text("Buyer Login",style: TextStyle(fontSize: 30,color: Colors.blue,fontWeight: FontWeight.bold),),
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
                onPressed: (){
                  FocusScope.of(context).unfocus();
                  Navigator.pushReplacementNamed(context, "/buyerHome");
                },
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  child: Text("New User? Signup!!!",style: TextStyle(color: Colors.blue),),
                  onTap: (){
                    Navigator.pushReplacementNamed(context, "/buyerSignup");
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
