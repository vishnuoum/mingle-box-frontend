import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CoderProjects extends StatefulWidget {
  const CoderProjects({Key? key}) : super(key: key);

  @override
  _CoderProjectsState createState() => _CoderProjectsState();
}

class _CoderProjectsState extends State<CoderProjects> {

  bool searchOn=false;
  bool search=false;
  TextEditingController searchController=TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("My Projects"),
          backgroundColor: Colors.blue,
          // elevation: 0,
        ),
        body: ListView(
          padding: EdgeInsets.only(left: 10,right: 10,top: 20),
          children: [
            GestureDetector(
              onTap: (){},
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
                                      Text("Project Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                      SizedBox(height: 3,),
                                      Text("Largest Bid : Rs.1000",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
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
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
    );
  }
}
