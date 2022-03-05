import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mingle_box/coder/services/coderExam.dart';
class CoderExam extends StatefulWidget {
  final Object? arguments;
  const CoderExam({Key? key,required this.arguments}) : super(key: key);

  @override
  State<CoderExam> createState() => _CoderExamState();
}

class _CoderExamState extends State<CoderExam> {

  dynamic result=[],radioList=[];
  CoderExamClass coderExamClass = CoderExamClass();
  bool loading=true;
  String loadText="Loading";
  var grp;


  @override
  void initState() {
    loadExam();
    super.initState();
  }

  void loadExam()async{
    Map arg= (widget.arguments as Map);
    result=await coderExamClass.coderExamQuestions(technologyId: arg["technologyId"]);
    print(result);
    if(result=="error"){
      setState(() {
        loadText="Something went wrong";
      });
      Future.delayed(Duration(seconds: 5),(){
        loadExam();
      });
    }
    else{
      result.forEach((value){
        radioList.add(-1);
      });
      setState(() {
        loading=false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    Map arg=(widget.arguments as Map);
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam (${arg["technology"]})"),
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
      ):ListView.builder(itemCount: result.length,itemBuilder: (BuildContext context,int index){
        var option=jsonDecode(result[index]["optionList"]);
        return Container(
          padding: EdgeInsets.only(top:10,bottom:30,left: 10,right: 10),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${index+1}. ${result[index]["question"]}",style: TextStyle(fontSize: 18),),
              ListView.separated(
                shrinkWrap: true,
                  primary: false,
                  separatorBuilder: (context, ind) {return Divider(height: 0,indent: 5,endIndent: 5,);},itemCount: option.length,itemBuilder: (BuildContext context,int ind){
                return ListTile(
                    onTap: (){},
                    leading: Radio(
                      value: option[ind],
                      groupValue: radioList[index],
                      onChanged: (dynamic val){
                        print(val);
                        setState(() {
                          radioList[index]=val;
                        });
                      },
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    title: Text(option[ind])
                );
              })
            ],
          )
        );
      }),
    );
  }
}
