import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mingle_box/coder/services/codersTechnology.dart';
import 'package:mingle_box/coder/services/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoderProfile extends StatefulWidget {
  const CoderProfile({Key? key}) : super(key: key);

  @override
  _CoderProfileState createState() => _CoderProfileState();
}

class _CoderProfileState extends State<CoderProfile> {

  Profile profile=Profile();
  CodersTechnology codersTechnology=CodersTechnology();
  late SharedPreferences sharedPreferences;
  bool loading=true;
  String loadText="Loading";


  dynamic result={};
  dynamic technology=[];
  bool techLoading=true;

  List<Widget> technologies=[];

  TextEditingController username=TextEditingController(text: ""),company=TextEditingController(text: ""),mail=TextEditingController(text: "");

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

  showAlertDialog(BuildContext context,String text) {

    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  void load()async{
    sharedPreferences=await SharedPreferences.getInstance();
    loadProfile();
  }

  void loadProfile()async{
    result=await profile.fetchProfile(id: sharedPreferences.getString("mail"));
    print(result);
    if(result!="error"){
      result["technology"]=jsonDecode(result["technology"]);
      setState(() {
        loading=false;
      });
      loadTechnology();
    }
    else{
      Future.delayed(Duration(seconds: 5),(){
        setState(() {
          loadText="Something went wrong";
        });
        loadProfile();
      });
    }
  }

  void loadTechnology()async{
    var techResult=await codersTechnology.getTechnologyList(tech: result["technology"]);
    print(techResult);
    technology=techResult;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.blue
        ),
        backgroundColor: Colors.transparent,
      ),
      body: loading?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,width: 50,child: CircularProgressIndicator(strokeWidth: 5,valueColor: AlwaysStoppedAnimation(Colors.blue),),),
            SizedBox(height: 10,),
            Text(loadText)
          ],
        ),
      ):
      ListView(
        padding: EdgeInsets.only(top: 20,left: 15,right: 15),
        children: [
          Text("Profile",style: TextStyle(color: Colors.blue,fontSize: 28,fontWeight: FontWeight.bold),),
          SizedBox(height: 30,),
          Text("Username",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Text("${result["username"]}",style: TextStyle(fontSize: 16),),
          SizedBox(height: 20,),
          Text("Mail ID",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Text("${result["mail"]}",style: TextStyle(fontSize: 16),),
          SizedBox(height: 20,),
          Text("Unique ID",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Text("${result["id"]}",style: TextStyle(fontSize: 16),),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Technology",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
              TextButton.icon(onPressed: (){


                showModalBottomSheet(enableDrag: true,isScrollControlled: true,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))),context: context, builder: (BuildContext context){
                  return StatefulBuilder(builder: (BuildContext context,setState)
                  {
                    return Container(
                      child: technology=="error"?Center(
                        child: Text("Something went wrong.",style: TextStyle(color: Colors.grey[600],fontSize: 17),),
                      ):ListView.separated(
                          padding: EdgeInsets.only(top: 60),
                          separatorBuilder: (context, index) {return index==0?SizedBox():Divider(height: 0,indent: 5,endIndent: 5,);},itemCount: technology.length+1,itemBuilder: (BuildContext context,int index){
                            if(index==0){
                              return Padding(padding: EdgeInsets.all(15),child: Text("Add Technology",style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),),);
                            }
                            index--;
                            return ListTile(
                              onTap: (){
                                Navigator.pushNamed(context, "/coderExam",arguments: {"technologyId":technology[index]["id"],"technology":technology[index]["technology"]});
                                print(technology[index]["id"]);
                              },
                              contentPadding: EdgeInsets.symmetric(horizontal: 15),
                              title: Text(technology[index]["technology"])
                            );
                          }),
                      );
                  });
                });

              }, icon: Icon(Icons.add),label: Text("Add New Tech"),)
            ],
          ),
          SizedBox(height: 10,),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: result["technology"]==null?0:result["technology"].length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(result["technology"][index]),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(height: 0,);
            },
          )

        ],
      ),
      floatingActionButton: loading?null:FloatingActionButton(
        onPressed: (){

          username.text=result["username"];
          mail.text=result["mail"];

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
                    Text("Username"),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200]
                      ),
                      child: TextField(
                        textCapitalization: TextCapitalization.words,
                        controller: username,
                        focusNode: null,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Username'
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text("Mail (not editable)"),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200]
                      ),
                      child: TextField(
                        enabled: false,
                        keyboardType: TextInputType.emailAddress,
                        controller: mail,
                        // textCapitalization: TextCapitalization.sentences,
                        focusNode: null,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Mail ID'
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextButton(onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if(username.text==result["username"]){
                        showAlertDialog(context, "Please change your name if you wish.");
                      }
                      else if (username.text.length != 0 && mail.text.length!=0) {
                        showLoading(context);
                        var res=await profile.editProfile(id: sharedPreferences.getString("mail"), username: username.text);
                        if(res=="done"){
                          loading=true;
                          Navigator.pop(context);
                          Navigator.pop(context);
                          loadProfile();
                        }
                        else{
                          Navigator.pop(context);
                          showAlertDialog(context, "Something went wrong. Try again");
                        }
                      }
                    },
                      child: Text("Update", style: TextStyle(fontSize: 17),),
                      style: TextButton.styleFrom(shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.blue,
                          primary: Colors.white,
                          padding: EdgeInsets.all(18)),),
                    SizedBox(height: 15,),
                    TextButton(onPressed: () async{
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
        child: Icon(Icons.edit),
      ),
    );
  }
}
