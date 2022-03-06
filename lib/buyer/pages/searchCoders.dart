import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mingle_box/buyer/services/service.dart';

class BuyerSearchCoders extends StatefulWidget {
  const BuyerSearchCoders({Key? key}) : super(key: key);

  @override
  _BuyerSearchCodersState createState() => _BuyerSearchCodersState();
}

class _BuyerSearchCodersState extends State<BuyerSearchCoders> {

  bool loading=true;
  String text="Loading";
  Service service=Service();
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
  void initState() {
    load();
    super.initState();
  }

  void load({String query=""})async{

    if(!loading){
      setState(() {
        loading=true;
      });
    }

    coders=await service.codersList(query: query);
    if(coders=="error"){
      setState(() {
        text="Something went wrong";
      });
      Future.delayed(Duration(seconds: 5),(){
        load(query: query);
      });
    }
    else{
      print(coders);
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
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      controller: searchController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                          fillColor: Colors.white),
                      onFieldSubmitted: (query){
                        searchController.clear();
                        setState(() {
                          searchOn=false;
                          search=false;
                        });
                        load(query: query);
                      },
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
              :Text("Coders"),
          backgroundColor: Colors.blue,
          // elevation: 0,
          actions: searchOn?[]:[
            IconButton(onPressed: loading?null:(){
              load();
            }, icon: Icon(Icons.refresh),
            ),
            IconButton(onPressed: loading?null:(){
              setState(() {
                searchOn=true;
                search=true;
              });
            }, icon: Icon(Icons.search),
            ),
            SizedBox(width: 5,)
          ],
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
        ):search?SizedBox():ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black,
              thickness: 0.1,
              height: 0,
              indent: 5,
              endIndent: 5,
            ),
            padding: const EdgeInsets.only(top: 8),
            itemCount: coders.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: (){},
                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                leading: CircleAvatar(
                  radius: 30,
                  child: Text(coders[index]["username"][0].toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                title: Text("${coders[index]["username"]}"),
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
