import 'package:flutter/material.dart';

class BuyerSignup extends StatefulWidget {
  const BuyerSignup({Key? key}) : super(key: key);

  @override
  _BuyerSignupState createState() => _BuyerSignupState();
}

class _BuyerSignupState extends State<BuyerSignup> {
  TextEditingController eMail=TextEditingController(text: ""),password=TextEditingController(text: ""),
  name=TextEditingController(text: ""),repeatPassword=TextEditingController(text: ""),company=TextEditingController(text: "");

  String? dropValue="Select an option";

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
                onPressed: (){
                  FocusScope.of(context).unfocus();
                  Navigator.pushReplacementNamed(context, "/buyerHome");
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
