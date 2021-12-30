import 'package:flutter/material.dart';

class CoderProfile extends StatefulWidget {
  const CoderProfile({Key? key}) : super(key: key);

  @override
  _CoderProfileState createState() => _CoderProfileState();
}

class _CoderProfileState extends State<CoderProfile> {

  dynamic result={
    "id":"id",
    "username":"name",
    "mail":"hello@gmail.com",
    "technology":["python","java","c"],
  };

  List<Widget> technologies=[];

  TextEditingController username=TextEditingController(text: ""),company=TextEditingController(text: ""),mail=TextEditingController(text: "");


  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed:  () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.blue
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
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
              TextButton.icon(onPressed: (){}, icon: Icon(Icons.add),label: Text("Add New Tech"),)
            ],
          ),
          SizedBox(height: 10,),
          ListView.separated(
            shrinkWrap: true,
            itemCount: result["technology"].length,
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
      floatingActionButton: FloatingActionButton(
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
                            hintText: 'Phone No.'
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextButton(onPressed: () async {
                      if (username.text.length != 0 &&
                          company.text.length != 0 && mail.text.length!=0) {}
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
