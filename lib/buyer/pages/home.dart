

import 'package:flutter/material.dart';
import 'package:mingle_box/buyer/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BuyerHome extends StatefulWidget {
  const BuyerHome({Key? key}) : super(key: key);

  @override
  _BuyerHomeState createState() => _BuyerHomeState();
}

class _BuyerHomeState extends State<BuyerHome> {

  late SharedPreferences sharedPreferences;
  bool loading=true;
  dynamic result=[];

  Service service=Service();
  String text="Loading";

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
    loadSP();
    super.initState();
  }

  void loadSP()async{
    sharedPreferences=await SharedPreferences.getInstance();
    load();
  }

  void load()async{
    setState(() {});
    result= await service.loadDashboard(id: sharedPreferences.getString("mail"));
    if(result=="error"){
      setState(() {
        text="Something went wrong";
      });
      Future.delayed(Duration(seconds: 5),(){
        load();
      });
    }
    else{
      text="Loading";
      setState(() {
        loading=false;
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
      drawer: Drawer(
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
              onTap: ()async{
                Navigator.pop(context);
                await Navigator.pushNamed(context, "/buyerChatList");
                loading=true;
                load();
              },
            ),
            ListTile(
              title: Text("Projects"),
              onTap: ()async{
                Navigator.pop(context);
                await Navigator.pushNamed(context, "/buyerProject");
                loading=true;
                load();
              },
            ),
            ListTile(
              title: Text("Coders"),
              onTap: ()async{
                Navigator.pop(context);
                await Navigator.pushNamed(context, "/buyerSearchCoders");
                loading=true;
                load();
              },
            ),
            ListTile(
              title: Text("Bid History"),
              onTap: ()async{
                Navigator.pop(context);
                await Navigator.pushNamed(context, "/buyerBidHistory");
                loading=true;
                load();
              },
            ),
            ListTile(
              title: Text("Request History"),
              onTap: ()async{
                Navigator.pop(context);
                await Navigator.pushNamed(context, "/buyerRequestHistory");
                loading=true;
                load();
              },
            ),
            ListTile(
              title: Text("Profile"),
              onTap: ()async{
                Navigator.pop(context);
                await Navigator.pushNamed(context, "/buyerProfile");
                loading=true;
                load();
              },
            ),
            ListTile(
              title: Text("Payment"),
              onTap: ()async{
                Navigator.pop(context);
                await Navigator.pushNamed(context, "/buyerPayment");
                loading=true;
                load();
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
            Text(text)
          ],
        ),
      ):ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(height: 100),
          Text("Buyer Dashboard",style: TextStyle(color: Colors.blue,fontSize: 28,fontWeight: FontWeight.bold),),
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
                Text("No. of Bids",style: TextStyle(fontSize: 17,color: Colors.blue[800])),
                SizedBox(height: 10,),
                Text(result[0]["bids"].toString(),style: TextStyle(fontSize: 25,color: Colors.blue[700],fontWeight: FontWeight.bold),),
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
                Text("No. of Requests",style: TextStyle(fontSize: 17,color: Colors.blue[800]),),
                SizedBox(height: 10,),
                Text(result[0]['requests'].toString(),style: TextStyle(fontSize: 25,color: Colors.blue[700],fontWeight: FontWeight.bold),),
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
                Text("Amount Spent",style: TextStyle(fontSize: 17,color: Colors.blue[800]),),
                SizedBox(height: 10,),
                Text("Rs.${result[0]["spent"].toString()}",style: TextStyle(fontSize: 25,color: Colors.blue[700],fontWeight: FontWeight.bold),),
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
