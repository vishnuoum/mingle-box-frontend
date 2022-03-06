import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mingle_box/coder/services/coderExam.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CoderExam extends StatefulWidget {
  final Object? arguments;
  const CoderExam({Key? key,required this.arguments}) : super(key: key);

  @override
  State<CoderExam> createState() => _CoderExamState();
}

class _CoderExamState extends State<CoderExam> {

  dynamic result=[],radioList=[],answers=[];
  CoderExamClass coderExamClass = CoderExamClass();
  bool loading=true;
  String loadText="Loading";
  var grp;
  late SharedPreferences sharedPreferences;


  @override
  void initState() {
    load();
    loadExam();
    super.initState();
  }

  void load()async{
    sharedPreferences=await SharedPreferences.getInstance();
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
        answers.add(0);
      });
      setState(() {
        loading=false;
      });
    }
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
            Text("Submitting")
          ],
        ),
      ),
    );

    showDialog(context: context,builder:(BuildContext context){
      return WillPopScope(onWillPop: ()async => false,child: alert);
    });
  }

  showExamResult(BuildContext context,String res){
    Widget okButton=TextButton(onPressed: (){
      Navigator.pop(context);
      Navigator.pop(context);
    }, child: Text("Ok"));
    AlertDialog alert =AlertDialog(
      content: Text(res),
      title: Text("Exam Result"),
      actions: [okButton],
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
      ):ListView.builder(itemCount: result.length+1,itemBuilder: (BuildContext context,int index){
        if(index==result.length){
          return Padding(padding: EdgeInsets.only(top:0,left: 10,right: 10,bottom: 50),
          child: TextButton(
              onPressed: ()async{
                if(answers.length==result.length){
                  showLoading(context);
                  var examResult=await coderExamClass.coderExamSubmit(answers: answers, id: sharedPreferences.getString("mail"),technologyId:arg["technologyId"]);
                  if(examResult=="error"){
                    Navigator.pop(context);
                    alertDialog("Something went wrong. Try again.");
                  }
                  else{
                    Navigator.pop(context);
                    showExamResult(context, "Your scored ${examResult["score"]}% in the test.");
                  }
                }
                else{
                  alertDialog("Please answer all the questions!!");
                }
              },
              child: Text("Submit Exam",style: TextStyle(color: Colors.white,fontSize: 17),),
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(20),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            ),
            ),
          );
        }
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
                          answers[index]={"questionId":result[index]["id"],"answer":val};
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
