

import 'package:flutter/material.dart';
import 'package:mingle_box/coder/services/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoderHome extends StatefulWidget {
  const CoderHome({Key? key}) : super(key: key);

  @override
  _CoderHomeState createState() => _CoderHomeState();
}

class _CoderHomeState extends State<CoderHome> {
  
  dynamic result={"completedProjects":"10","uniqueBuyers":"8","earned":"10000"};
  late SharedPreferences sharedPreferences;
  Dashboard dashboard=Dashboard();
  bool loading=true;
  String loadText="Loading";

  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  List<_SalesData> data1 = [
    _SalesData('Jan', 65),
    _SalesData('Feb', 18),
    _SalesData('Mar', 35),
    _SalesData('Apr', 12),
    _SalesData('May', 30)
  ];

  @override
  void initState() {
    load();
    super.initState();
  }

  void load()async{
    sharedPreferences=await SharedPreferences.getInstance();
    loadDash();
  }

  void loadDash()async{
    result=await dashboard.fetch(id: sharedPreferences.getString("mail"));
    print(result.runtimeType);
    if(result!="error") {
      setState(() {
        loading = false;
        loadText="Loading";
      });
    }
    else{
      Future.delayed(Duration(seconds: 5),(){
        setState(() {
          loadText="Something went wrong.";
        });
        loadDash();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.blue
        ),
      ),
      drawer: loading?null:Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    child: Text("M",style: TextStyle(fontSize: 30),),
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white,
                    radius: 35,
                  ),
                  SizedBox(height: 15,),
                  Text(loading?"Username":result[0]["username"],style: TextStyle(color: Colors.white,fontSize: 18),),
                  SizedBox(height: 5,),
                  Text(loading?"Mail":result[0]["mail"],style: TextStyle(color: Colors.white),)
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text("Chats"),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, "/coderChatList");
              },
            ),
            ListTile(
              title: Text("My Projects"),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, "/coderProjects");
              },
            ),
            ListTile(
              title: Text("Requests"),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, "/coderRequests");
              },
            ),
            ListTile(
              title: Text("Profile"),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, "/coderProfile");
              },
            ),
            ListTile(
              title: Text("Payments"),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, "/coderPayment");
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: (){
                Navigator.pop(context);
                sharedPreferences.clear();
                Navigator.pushReplacementNamed(context, "/choose");
              },
            ),
          ],
        ),
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
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(height: 100),
          Text("Coder Dashboard",style: TextStyle(color: Colors.blue,fontSize: 28,fontWeight: FontWeight.bold),),
          SizedBox(height: 40,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue,width: 3)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Completed Projects",style: TextStyle(fontSize: 17,color: Colors.blue[800])),
                SizedBox(height: 10,),
                Text("${result[0]["completedProjects"]}",style: TextStyle(fontSize: 25,color: Colors.blue[700],fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
            decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue,width: 3)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Unique Buyers",style: TextStyle(fontSize: 17,color: Colors.blue[800]),),
                SizedBox(height: 10,),
                Text("${result[0]["uniqueBuyers"]}",style: TextStyle(fontSize: 25,color: Colors.blue[700],fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
            decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue,width: 3)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Amount Earned",style: TextStyle(fontSize: 17,color: Colors.blue[800]),),
                SizedBox(height: 10,),
                Text("Rs. ${result[0]["earned"]}",style: TextStyle(fontSize: 25,color: Colors.blue[700],fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          SizedBox(height: 20,),
          // SfCartesianChart(
          //     primaryXAxis: CategoryAxis(),
          //     zoomPanBehavior: ZoomPanBehavior(enablePanning: true,enablePinching: true),
          //     // Chart title
          //     title: ChartTitle(text: 'Half yearly sales analysis',textStyle: TextStyle(color: Colors.black,fontSize: 15)),
          //     // Enable legend
          //     legend: Legend(isVisible: false),
          //     // Enable tooltip
          //     tooltipBehavior: TooltipBehavior(enable: true),
          //     series: <ChartSeries<_SalesData, String>>[
          //       LineSeries<_SalesData, String>(
          //         color: Colors.blue,
          //           dataSource: data,
          //           xValueMapper: (_SalesData sales, _) => sales.year,
          //           yValueMapper: (_SalesData sales, _) => sales.sales,
          //           name: 'Sales',
          //           // Enable data label
          //           dataLabelSettings: DataLabelSettings(isVisible: false))
          //     ]),
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
