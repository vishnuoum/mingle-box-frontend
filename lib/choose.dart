import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Choose extends StatefulWidget {
  const Choose({Key? key}) : super(key: key);

  @override
  _ChooseState createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {

  bool loading=true;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    load();
    super.initState();
  }

  void load()async{
    print('load');
    sharedPreferences=await SharedPreferences.getInstance();
    if(sharedPreferences.containsKey("type")){
      print("load");
      print(sharedPreferences.getString("type"));
      if(sharedPreferences.getString("type")=="coder"){
        print('coder');
        Navigator.pushReplacementNamed(context, "/coderHome");
      }
      if(sharedPreferences.getString("type")=="buyer"){
        print('buyer');
        Navigator.pushReplacementNamed(context, "/buyerHome");
      }
    }
    else{
      setState(() {
        loading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading?Center(
        child: SizedBox(height: 50,width: 50,child: CircularProgressIndicator(strokeWidth: 5,valueColor: AlwaysStoppedAnimation(Colors.blue),),),
      ):SafeArea(
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
              Text("I am a ................................",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 50,),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/coderLogin");
                  },
                  child: Text("Coder",style: TextStyle(fontSize: 17,color: Colors.blue),),
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/buyerLogin");
                  },
                  child: Text("Buyer",style: TextStyle(fontSize: 17,color: Colors.blue),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
