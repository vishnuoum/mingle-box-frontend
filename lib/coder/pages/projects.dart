import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mingle_box/coder/services/project.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoderProjects extends StatefulWidget {
  const CoderProjects({Key? key}) : super(key: key);

  @override
  _CoderProjectsState createState() => _CoderProjectsState();
}

class _CoderProjectsState extends State<CoderProjects> {

  dynamic result=[],tech=[];

  bool searchOn=false;
  bool search=false;
  TextEditingController searchController=TextEditingController(text: "");
  late SharedPreferences sharedPreferences;
  bool loading=true;
  String loadText="Loading";

  Project project=Project();

  TextEditingController projectName=TextEditingController(text: ""),description=TextEditingController(text: ""),cost=TextEditingController(text: ""),technology=TextEditingController();

  @override
  void initState() {
    load();
    super.initState();
  }

  void load()async{
    sharedPreferences=await SharedPreferences.getInstance();
    loadProjects();
  }

  void loadProjects()async{
    result=await project.projectList(id: sharedPreferences.getString("mail"));
    print(result);
    if(result=="error"){
      setState(() {
        loadText="Something went wrong";
      });
      Future.delayed(Duration(seconds: 5),(){loadProjects();});
    }
    else{
      setState(() {
        loading=false;
        loadText="Loading";
      });
    }
  }

  showInfoDialog(BuildContext context,int index) {


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Project Info"),
      content: Container(
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Project Name",style: TextStyle(fontWeight: FontWeight.bold),),
              Text(result[index]["name"]),
              SizedBox(height: 10),
              Text("Project Cost",style: TextStyle(fontWeight: FontWeight.bold)),
              Text(result[index]["cost"]),
              SizedBox(height: 10,),
              Text("Technology",style: TextStyle(fontWeight: FontWeight.bold)),
              Text(result[index]["technology"].substring(1,result[index]["technology"].length-1).replaceAll(RegExp(r'"'), "")),
              SizedBox(height: 10,),
              Text("Added Date",style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${DateTime.parse(result[index]["timestamp"]).day}/${DateTime.parse(result[index]["timestamp"]).month}/${DateTime.parse(result[index]["timestamp"]).year}"),
              SizedBox(height: 10,),
              Text("Largest Bid",style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Rs. ${result[index]["largestBid"]}"),
              SizedBox(height: 10,),
              Text("Status",style: TextStyle(fontWeight: FontWeight.bold)),
              Text(result[index]["finalBid"]==null?"On Bid":"Completed"),
              SizedBox(height: 10,),
              Text("Description",style: TextStyle(fontWeight: FontWeight.bold)),
              Text(result[index]["description"]),
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("My Projects"),
          backgroundColor: Colors.blue,
          // elevation: 0,
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
        ):ListView.builder(
            itemCount: result.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (BuildContext context,int index){
          return GestureDetector(
            onTap: (){
              showInfoDialog(context,index);
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
                      left: 10,
                      top: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.all(5),
                        child: Text(result[index]["finalCost"]==null?"On Bid":"Completed",style: TextStyle(fontSize: 12),),
                      )
                  ),
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
                                    Text(result[index]["name"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    SizedBox(height: 3,),
                                    Text("${result[index]["finalCost"]==null? "Largest Bid":"Bid"} : Rs.${result[index]["largestBid"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
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
                                    Navigator.pushNamed(context, "/coderProjectBidders",arguments: {"id":result[index]["id"]});
                                    // await canLaunch("tel:${result[index]["phone"]}") ? await launch("tel:${result[index]["phone"]}") : throw 'Could not launch phone app';
                                  },
                                  child: SizedBox(width: 56, height: 56, child: Icon(Icons.arrow_forward,color: Colors.white,)),
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
        }),
      floatingActionButton: loading?null:FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              enableDrag: true,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))),context: context, builder: (BuildContext context){
            return StatefulBuilder(builder: (BuildContext context,setState)
            {
              return ListView(
                padding: EdgeInsets.only(top: 20, left: 20,right:20,bottom:MediaQuery.of(context).viewInsets.bottom

                ),
                children: [
                  SizedBox(height: 60,),
                  Align(child: Text("Add Project", style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),),
                    alignment: Alignment.centerLeft,),
                  SizedBox(height: 40,),
                  Text("Project Name"),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                    ),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      controller: projectName,
                      focusNode: null,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Project Name'
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text("Project Technology"),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,itemCount: tech.length,itemBuilder: (BuildContext context,int index){
                      print("hai");
                      return Container(
                        margin: EdgeInsets.only(right: 10,top:5),
                        padding: EdgeInsets.symmetric(vertical:3,horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black)
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(tech[index],style: TextStyle(fontSize: 12),),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: (){
                                setState((){
                                  tech.removeAt(index);
                                });
                              },
                              child: Text("x"),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                    ),
                    child: TextField(
                      textInputAction: TextInputAction.go,
                      textCapitalization: TextCapitalization.words,
                      controller: technology,
                      focusNode: null,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Project Technology'
                      ),
                      onSubmitted: (text){
                        technology.text="";
                        setState((){
                          tech.add(text);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text("Project Description"),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                    ),
                    child: TextField(
                      maxLines: null,
                      textCapitalization: TextCapitalization.words,
                      controller: description,
                      focusNode: null,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Project Description'
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text("Project Cost"),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.words,
                      controller: cost,
                      focusNode: null,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Project Cost (in Rs.)'
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextButton(onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (projectName.text.length != 0 && cost.text.length!=0 && description.text.length!=0 && tech.length!=0) {
                      showLoading(context);
                      var res=await project.addProject(id: sharedPreferences.getString("mail"), name: projectName.text, description: description.text, cost: cost.text, tech: tech);
                      if(res=="done"){
                        loading=true;
                        Navigator.pop(context);
                        Navigator.pop(context);
                        loadProjects();
                      }
                      else{
                        Navigator.pop(context);
                        showAlertDialog(context, "Something went wrong. Try again");
                      }
                    }
                    else{
                      showAlertDialog(context, "Please complete the form");
                    }
                  },
                    child: Text("Add", style: TextStyle(fontSize: 17),),
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
              );
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
