import 'package:flutter/material.dart';

class Choose extends StatefulWidget {
  const Choose({Key? key}) : super(key: key);

  @override
  _ChooseState createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70,),
              Text("Choose an option!!",style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 70,),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: () {

                  },
                  child: Text("Coder",style: TextStyle(fontSize: 17,color: Colors.white),),
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/buyerLogin");
                  },
                  child: Text("Buyer",style: TextStyle(fontSize: 17,color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
