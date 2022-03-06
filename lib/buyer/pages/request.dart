import 'package:flutter/material.dart';
import 'package:mingle_box/buyer/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerRequest extends StatefulWidget {
  const BuyerRequest({Key? key}) : super(key: key);

  @override
  State<BuyerRequest> createState() => _BuyerRequestState();
}

class _BuyerRequestState extends State<BuyerRequest> {

  dynamic tech=[];
  TextEditingController requestName= TextEditingController(text: ""),description=TextEditingController(text: ""),technology=TextEditingController(text: "");
  late SharedPreferences sharedPreferences;
  Service service = Service();

  @override
  void initState() {
    load();
    super.initState();
  }

  void load()async{
    sharedPreferences=await SharedPreferences.getInstance();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Request"),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20, left: 20,right:20,bottom:MediaQuery.of(context).viewInsets.bottom

        ),
        children: [
          Text("Request Name"),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200]
            ),
            child: TextField(
              textCapitalization: TextCapitalization.words,
              controller: requestName,
              focusNode: null,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Request Name'
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
          TextButton(onPressed: () async {
            FocusScope.of(context).unfocus();
            if (requestName.text.length != 0 && description.text.length!=0 && tech.length!=0) {
              showLoading(context);
              var res=await service.buyerAddRequest(id: sharedPreferences.getString("mail"), name: requestName.text, description: description.text, tech: tech);
              if(res=="done"){
                Navigator.pop(context);
                Navigator.pop(context);
              }
              else{
                Navigator.pop(context);
                alertDialog("Something went wrong. Try again");
              }
            }
            else{
              alertDialog("Please complete the form");
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
      ),
    );
  }
}
