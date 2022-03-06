import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mingle_box/buyer/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerProjects extends StatefulWidget {
  const BuyerProjects({Key? key}) : super(key: key);

  @override
  _BuyerProjectsState createState() => _BuyerProjectsState();
}

class _BuyerProjectsState extends State<BuyerProjects> {

  bool loading=true;
  String text="Loading";
  dynamic projectList=[];

  TextEditingController name=TextEditingController(text: ""),amount=TextEditingController(text: "");

  Service service=Service();
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    loadSP();
    super.initState();
  }

  void loadSP()async{
    sharedPreferences= await SharedPreferences.getInstance();
    load();
  }

  void load()async{
    setState(() {});
    projectList= await service.projectList();
    if(projectList=="error"){
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

  showInfoDialog(BuildContext context,int index) {

    print(projectList[index]);

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Project Info"),
      content: Container(
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Project Name",style: TextStyle(fontWeight: FontWeight.bold),),
              Text(projectList[index]["name"]),
              SizedBox(height: 10),
              Text("Coder",style: TextStyle(fontWeight: FontWeight.bold),),
              Text(projectList[index]["coder"]),
              SizedBox(height: 10),
              Text("Technology",style: TextStyle(fontWeight: FontWeight.bold)),
              Text(projectList[index]["technology"].substring(1,projectList[index]["technology"].length-1).replaceAll(RegExp(r'"'), "")),
              SizedBox(height: 10,),
              Text("Highest Bid",style: TextStyle(fontWeight: FontWeight.bold)),
              Text(projectList[index]["highestBid"]),
              SizedBox(height: 10,),
              Text("Added Date",style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${DateTime.parse(projectList[index]["timestamp"]).day}/${DateTime.parse(projectList[index]["timestamp"]).month}/${DateTime.parse(projectList[index]["timestamp"]).year}"),
              SizedBox(height: 10,),
              Text("Initial Cost",style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Rs. ${projectList[index]["cost"]}"),
              SizedBox(height: 10,),
              Text("Description",style: TextStyle(fontWeight: FontWeight.bold)),
              Text(projectList[index]["description"]),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
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

  showBottomSheet({required String projectId,required String amt,required String projectName}){
    name.text=projectName;
    amount.text=amt;
    showModalBottomSheet(enableDrag: true,isScrollControlled: true,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))),context: context, builder: (BuildContext context){
      return StatefulBuilder(builder: (BuildContext context,setState)
      {
        return Container(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            children: [
              SizedBox(height: 60,),
              Align(child: Text("Update Bid Amount", style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),),
                alignment: Alignment.centerLeft,),
              SizedBox(height: 40,),
              Text("Project (not editable)"),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]
                ),
                child: TextField(
                  enabled: false,
                  textCapitalization: TextCapitalization.words,
                  controller: name,
                  focusNode: null,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Project name'
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text("Amount"),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: amount,
                  // textCapitalization: TextCapitalization.sentences,
                  focusNode: null,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Amount'
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextButton(onPressed: () async {
                FocusScope.of(context).unfocus();
                if (name.text.length == 0 ||
                    amount.text.length == 0) {
                  alertDialog("Please complete the form!!");
                  return;
                }
                if(double.parse(amount.text)<=double.parse(amt)){
                  alertDialog("You must provide an amount greater than previous bid.");
                  return;
                }
                showLoading(context);
                var res=await service.buyerBid(id: sharedPreferences.getString("mail"),amount: amount.text,projectId: projectId);
                if(res=="done"){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  loading=true;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Projects"),
          backgroundColor: Colors.blue,
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
        ):ListView.builder(
          itemCount: projectList.length,
          padding: EdgeInsets.only(left: 10,right: 10,top: 20),
          itemBuilder: (BuildContext context,int index){
            return GestureDetector(
              onTap: (){
                showInfoDialog(context, index);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("assets/pic.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 220,
                padding: EdgeInsets.zero,
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 0,
                        width: MediaQuery.of(context).size.width-20,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                            ),],
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(10),
                          height: 90,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Column(
                                    children: [
                                      Text("${projectList[index]["name"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                      SizedBox(height: 3,),
                                      Text("Largest Bid : Rs.${projectList[index]["highestBid"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                      SizedBox(height: 3,),
                                      Text("By ${projectList[index]['coder']}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 16),),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  )
                              ),
                              ClipOval(
                                child: Material(
                                  color: Colors.blue, // Button color
                                  child: InkWell(
                                    splashColor: Colors.blue[700], // Splash color
                                    focusColor: Colors.blue[700],
                                    hoverColor: Colors.blue[700],
                                    highlightColor: Colors.blue[700],
                                    onTap: () async{
                                      showBottomSheet(projectId: projectList[index]["id"], amt: projectList[index]["highestBid"]==0?projectList[index]["cost"]:projectList[index]["highestBid"], projectName: projectList[index]["name"]);
                                    },
                                    child: SizedBox(width: 56, height: 56, child: Icon(CupertinoIcons.money_dollar,color: Colors.white,)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}
