import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyerSearchCoders extends StatefulWidget {
  const BuyerSearchCoders({Key? key}) : super(key: key);

  @override
  _BuyerSearchCodersState createState() => _BuyerSearchCodersState();
}

class _BuyerSearchCodersState extends State<BuyerSearchCoders> {

  bool searchOn=false;
  bool search=false;
  TextEditingController searchController=TextEditingController(text: "");

  dynamic coders=[
    {"id":"123","name":"name"},
    {"id":"123","name":"name"},
    {"id":"123","name":"name"},
    {"id":"123","name":"name"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: searchOn?
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(100)
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      autofocus: true,
                      controller: searchController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                          fillColor: Colors.white),
                    )
                ),
                SizedBox(width: 10,),
                GestureDetector(child: Icon(Icons.close),onTap: (){
                  searchController.clear();
                  setState(() {
                    searchOn=false;
                    search=false;
                  });
                },)
              ],
            ),
          )
              :Text("Search Coders"),
          backgroundColor: Colors.blue,
          // elevation: 0,
          actions: searchOn?[]:[
            IconButton(onPressed: (){
              setState(() {
                searchOn=true;
                search=true;
              });
            }, icon: Icon(Icons.search)),
            SizedBox(width: 5,)
          ],
        ),
        body: search?SizedBox():ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black,
              thickness: 0.05,
              height: 0,
            ),
            padding: const EdgeInsets.all(8),
            itemCount: coders.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: (){},
                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                leading: CircleAvatar(
                  radius: 25,
                  child: Text(coders[index]["name"][0].toUpperCase(),style: TextStyle(fontSize: 17),),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                title: Text("${coders[index]["name"]}"),
                trailing: IconButton(
                  onPressed: (){},
                  color: Colors.blue,
                  icon: Icon(Icons.chat),
                ),
              );
            }
        )
    );
  }
}
