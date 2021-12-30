import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class BuyerRequestHistory extends StatefulWidget {
  const BuyerRequestHistory({Key? key}) : super(key: key);

  @override
  _BuyerRequestHistoryState createState() => _BuyerRequestHistoryState();
}

class _BuyerRequestHistoryState extends State<BuyerRequestHistory> {

  dynamic requests=[{"id":"123","name":"Project Name","responses":"100","technology":["python","c"]},{"id":"123","name":"Project Name","responses":"100","technology":["python","c"]},{"id":"123","name":"Project Name","responses":"100","technology":["python","c"]}];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Request history"),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: requests.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                  title: Text(requests[index]["name"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  subtitle: Text("Responses: ${requests[index]["responses"]}",style: TextStyle(fontSize: 15)),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Requested Technologies:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: requests[index]["technology"].length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: Text(requests[index]["technology"][i]),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(height: 0,);
                      },
              ),],
                trailing: IconButton(color: Colors.blue,icon: Icon(Icons.person),onPressed: (){},tooltip: "Coders Responded",),
              );
            }
        ),
    );
  }
}

// GestureDetector(
// onTap: (){},
// child: Container(
// margin: EdgeInsets.only(bottom: 10),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// image: DecorationImage(
// image: AssetImage("assets/pic.jpg"),
// fit: BoxFit.cover,
// ),
// ),
// height: 220,
// padding: EdgeInsets.zero,
// child: Stack(
// children: [
// Positioned(
// bottom: 0,
// width: MediaQuery.of(context).size.width-20,
// child: Container(
// width: double.infinity,
// decoration: BoxDecoration(
// boxShadow: [BoxShadow(
// color: Colors.grey,
// blurRadius: 5.0,
// ),],
// borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
// color: Colors.white,
// ),
// padding: EdgeInsets.all(10),
// height: 90,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: Column(
// children: [
// Text("${requests[index]["name"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
// SizedBox(height: 3,),
// Text("No. of Responses: ${requests[index]["responses"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
// ],
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisSize: MainAxisSize.max,
// mainAxisAlignment: MainAxisAlignment.center,
// )
// ),
// ClipOval(
// child: Material(
// color: Colors.blue, // Button color
// child: InkWell(
// splashColor: Colors.blue[700], // Splash color
// focusColor: Colors.blue[700],
// hoverColor: Colors.blue[700],
// highlightColor: Colors.blue[700],
// onTap: () async{
// // await canLaunch("tel:${result[index]["phone"]}") ? await launch("tel:${result[index]["phone"]}") : throw 'Could not launch phone app';
// },
// child: SizedBox(width: 56, height: 56, child: Icon(Icons.person,color: Colors.white,)),
// ),
// ),
// )
// ],
// ),
// )
// )
// ],
// ),
// ),
// )




