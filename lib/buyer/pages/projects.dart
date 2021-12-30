import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mingle_box/buyer/services/service.dart';

class BuyerProjects extends StatefulWidget {
  const BuyerProjects({Key? key}) : super(key: key);

  @override
  _BuyerProjectsState createState() => _BuyerProjectsState();
}

class _BuyerProjectsState extends State<BuyerProjects> {

  bool loading=true;
  String text="Loading";
  dynamic projectList=[];

  Service service=Service();

  @override
  void initState() {
    load();
    super.initState();
  }

  void load()async{
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
                print("Hello");
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
                                      // await canLaunch("tel:${result[index]["phone"]}") ? await launch("tel:${result[index]["phone"]}") : throw 'Could not launch phone app';
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
