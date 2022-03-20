import 'package:flutter/material.dart';
import 'package:mingle_box/coder/services/coderExam.dart';

class CoderTechInfo extends StatefulWidget {
  final Map arguments;
  const CoderTechInfo({Key? key,required this.arguments}) : super(key: key);

  @override
  State<CoderTechInfo> createState() => _CoderTechInfoState();
}

class _CoderTechInfoState extends State<CoderTechInfo> {

  dynamic result=[];
  bool loading=true;
  String loadText="Loading";
  CoderExamClass coderExamClass = CoderExamClass();

  @override
  void initState() {
    loadInfo();
    super.initState();
  }

  void loadInfo()async{
    setState(() {});
    result = await coderExamClass.coderTechInfo(technology: widget.arguments["tech"], id: widget.arguments["id"]);
    if(result=="error"){
      setState(() {
        loadText="Something went wrong";
      });
      Future.delayed(Duration(seconds: 5),(){
        loadInfo();
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
        title: Text("Result"),
        elevation: 0,
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
      ):ListView(
        padding: EdgeInsets.all(10),
        children: [
          SizedBox(height: 10,),
          Text("Technology",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
          SizedBox(height: 5,),
          Text(widget.arguments["tech"][0].toUpperCase()+widget.arguments["tech"].substring(1),style: TextStyle(fontSize: 22),),
          SizedBox(height: 15,),
          Text("Score",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
          SizedBox(height: 5,),
          Text("${result["score"]}%" ,style: TextStyle(fontSize: 22),),
          SizedBox(height: 20,),
          TextButton(onPressed: ()async{
            await Navigator.pushNamed(context, "/coderExam",arguments: {"technologyId":result["id"],"technology":widget.arguments["tech"]});
            loading=true;
            loadInfo();
          }, child: Text("Re-appear for Test",style: TextStyle(fontSize: 17),),style: TextButton.styleFrom(padding: EdgeInsets.all(20)),)
        ],
      ),
    );
  }
}
