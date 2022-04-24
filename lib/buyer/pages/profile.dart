import 'package:flutter/material.dart';
import 'package:mingle_box/buyer/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerProfile extends StatefulWidget {
  const BuyerProfile({Key? key}) : super(key: key);

  @override
  _BuyerProfileState createState() => _BuyerProfileState();
}

class _BuyerProfileState extends State<BuyerProfile> {

  bool loading=true;
  String text="Loading";
  Service service=Service();
  late SharedPreferences sharedPreferences;


  dynamic result={
    "id":"id",
    "username":"name",
    "mail":"hello@gmail.com",
    "company":"company"
  };

  TextEditingController username=TextEditingController(text: ""),company=TextEditingController(text: ""),mail=TextEditingController(text: "");



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

  @override
  void initState() {
    loadSP();
    super.initState();
  }

  void loadSP()async{
    sharedPreferences=await SharedPreferences.getInstance();
    load();
  }

  void load()async{

    if(!loading) {
      setState(() {
        loading = true;
      });
    }


    result=await service.buyerProfile(id: sharedPreferences.getString("mail"));
    if(result=="error"){
      setState(() {
        text="Something went wrong";
      });
      Future.delayed(Duration(seconds: 5),(){
        load();
      });
    }
    else{
      text="Loading";
      setState(() {
        loading=false;
      });
    }

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
            Text(text)
          ],
        ),
      ):ListView(
        padding: EdgeInsets.only(top: 20,left: 15,right: 15),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Profile",style: TextStyle(color: Colors.blue,fontSize: 28,fontWeight: FontWeight.bold),),
              IconButton(onPressed: (){
                Navigator.pushNamed(context, "/buyerPasswordReset",arguments: {"id":sharedPreferences.getString("mail")});
              }, icon: Icon(Icons.vpn_key),color: Colors.blue,tooltip: "Change Password",)
            ],
          ),
          SizedBox(height: 30,),
          Text("Username",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Text("${result["username"]}",style: TextStyle(fontSize: 16),),
          SizedBox(height: 20,),
          Text("Company",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Text("${result["company"]}",style: TextStyle(fontSize: 16),),
          SizedBox(height: 20,),
          Text("Mail ID",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Text("${result["mail"]}",style: TextStyle(fontSize: 16),),
          SizedBox(height: 20,),
          Text("Verification Status",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Text("${result["verified"]=="yes"?"Verified":"Not Verified"}",style: TextStyle(fontSize: 16),),
          SizedBox(height: 20,),
          Text("Unique ID",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Text("${result["id"]}",style: TextStyle(fontSize: 16),),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          username.text=result["username"];
          company.text=result["company"];
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
                            hintText: 'Phone No.'
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text("Company"),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200]
                      ),
                      child: TextField(
                        textCapitalization: TextCapitalization.words,
                        controller: company,
                        focusNode: null,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Place'
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextButton(onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (username.text.length == 0 ||
                          company.text.length == 0 || mail.text.length==0) {
                        alertDialog("Please complete the form!!");
                        return;
                      }
                      showLoading(context);
                      var res=await service.editProfile(username: username.text, company: company.text, id: sharedPreferences.getString("mail"));
                      if(res=="done"){
                        Navigator.pop(context);
                        Navigator.pop(context);
                        load();
                      }
                      else{
                        Navigator.pop(context);
                        alertDialog("Something went wrong. Try again later.");
                      }
                    },
                      child: Text("Update", style: TextStyle(fontSize: 17),),
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
        child: Icon(Icons.edit),
      ),
    );
  }
}
