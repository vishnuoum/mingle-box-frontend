import 'package:flutter/material.dart';
import 'package:mingle_box/buyer/services/service.dart';

class BuyerResponders extends StatefulWidget {
  final Map? arguments;
  const BuyerResponders({Key? key,required this.arguments}) : super(key: key);

  @override
  State<BuyerResponders> createState() => _BuyerRespondersState();
}

class _BuyerRespondersState extends State<BuyerResponders> {

  Service service = Service();
  bool loading=true;
  String loadText="Loading";
  dynamic result=[];

  @override
  void initState() {
    loadResponders();
    super.initState();
  }

  void loadResponders()async{
    setState(() {});
    print(widget.arguments);
    result= await service.buyerRequestResponders(id: widget.arguments!["id"].toString());
    if(result=="error"){
      setState(() {
        loadText="Something went wrong";
      });
      Future.delayed(Duration(seconds: 5),(){
        loadResponders();
      });
    }
    else{
      setState(() {
        loading=false;
        loadText="Loading";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Responders"),
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
      ):result.length==0?Center(
        child: Text("Nothing to display.",style: TextStyle(color: Colors.grey[600],fontSize: 17),),
      ):
      ListView.separated(itemBuilder: (BuildContext context,int index){
        return ListTile(
          onTap: (){},
          contentPadding: EdgeInsets.all(2),
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            radius: 35,
            child: Text(result[index]["username"][0],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          title: Text(result[index]["username"],style: TextStyle(fontSize: 20),),
          subtitle: Text(result[index]["mail"],style: TextStyle(fontSize: 17,color: Colors.grey[600]),),
        );
      }, separatorBuilder: (context, index) {return Divider(height: 0,indent: 5,endIndent: 5,);}, itemCount: result.length),
    );
  }
}
