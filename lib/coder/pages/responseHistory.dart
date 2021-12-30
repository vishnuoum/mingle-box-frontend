import 'package:flutter/material.dart';

class CoderResponseHistory extends StatefulWidget {
  const CoderResponseHistory({Key? key}) : super(key: key);

  @override
  _CoderResponseHistoryState createState() => _CoderResponseHistoryState();
}

class _CoderResponseHistoryState extends State<CoderResponseHistory> {
  dynamic responses=[{"id":"123","name":"Project Name","respondedOn":"27/02/2021","buyerId":"123"}];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Response History"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: responses.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
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
                          width: double.infinity,
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
                                      Text("${responses[index]["name"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                      SizedBox(height: 3,),
                                      Text("Responded On: ${responses[index]["respondedOn"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
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
                                    child: SizedBox(width: 56, height: 56, child: Icon(Icons.person,color: Colors.white,)),
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
          }
      ),
    );
  }
}
