import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mingle_box/buyer/pages/bidHistory.dart';
import 'package:mingle_box/choose.dart';
import 'package:mingle_box/buyer/pages/home.dart';
import 'package:mingle_box/buyer/pages/projects.dart';
import 'package:mingle_box/buyer/pages/login.dart';
import 'package:mingle_box/buyer/pages/signup.dart';

import 'buyer/pages/chatList.dart';
import 'buyer/pages/payment.dart';
import 'buyer/pages/profile.dart';
import 'buyer/pages/requestHistory.dart';
import 'buyer/pages/searchCoders.dart';
import 'coder/pages/chatList.dart';
import 'coder/pages/home.dart';
import 'coder/pages/login.dart';
import 'coder/pages/payment.dart';
import 'coder/pages/profile.dart';
import 'coder/pages/projects.dart';
import 'coder/pages/requests.dart';
import 'coder/pages/responseHistory.dart';
import 'coder/pages/signup.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.blue, // status bar color
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/buyerHome":(context) => BuyerHome(),
        "/buyerLogin": (context) => BuyerLogin(),
        "/buyerSignup":(context) => BuyerSignup(),
        "/buyerProject":(context) => BuyerProjects(),
        "/buyerBidHistory":(context) => BuyerBidHistory(),
        "/buyerSearchCoders":(context) => BuyerSearchCoders(),
        "/buyerRequestHistory":(context) => BuyerRequestHistory(),
        "/buyerProfile":(context) => BuyerProfile(),
        "/buyerPayment":(context) => BuyerPayment(),
        "/buyerChatList":(context) => BuyerChatList(),
        "/choose":(context) => Choose(),
        "/coderHome":(context) => CoderHome(),
        "/coderLogin": (context) => CoderLogin(),
        "/coderSignup":(context) => CoderSignup(),
        "/coderProjects":(context) => CoderProjects(),
        "/coderProfile":(context) => CoderProfile(),
        "/coderPayment":(context) => CoderPayment(),
        "/coderRequests":(context) => CoderRequests(),
        "/coderChatList":(context) => CoderChatList(),
        "/coderResponseHistory":(context) => CoderResponseHistory(),
      },
      initialRoute: "/choose",
    );
  }
}

