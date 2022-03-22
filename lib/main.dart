import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mingle_box/buyer/pages/bidHistory.dart';
import 'package:mingle_box/choose.dart';
import 'package:mingle_box/buyer/pages/home.dart';
import 'package:mingle_box/buyer/pages/projects.dart';
import 'package:mingle_box/buyer/pages/login.dart';
import 'package:mingle_box/buyer/pages/signup.dart';
import 'package:mingle_box/coder/pages/coderExam.dart';
import 'package:mingle_box/coder/pages/passwordReset.dart';
import 'package:mingle_box/coder/pages/projectBidders.dart';
import 'package:mingle_box/coder/pages/techInfo.dart';

import 'buyer/pages/chatList.dart';
import 'buyer/pages/makePayement.dart';
import 'buyer/pages/passwordReset.dart';
import 'buyer/pages/payment.dart';
import 'buyer/pages/profile.dart';
import 'buyer/pages/request.dart';
import 'buyer/pages/requestHistory.dart';
import 'buyer/pages/responders.dart';
import 'buyer/pages/searchCoders.dart';
import 'coder/pages/chatList.dart';
import 'coder/pages/home.dart';
import 'coder/pages/login.dart';
import 'coder/pages/payment.dart';
import 'coder/pages/profile.dart';
import 'coder/pages/projects.dart';
import 'coder/pages/requests.dart';
import 'coder/pages/signup.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.blue, // status bar color
  ));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    initOneSignal();
    super.initState();
  }

  void initOneSignal()async{
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId("94000518-7da5-44a5-a338-7efd79d09099");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
  }

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
        "/makePayment":(context) => MakePayment(),
        "/buyerRequest":(context) => BuyerRequest(),
        "/buyerResponders":(context) => BuyerResponders(arguments: ModalRoute.of(context)!.settings.arguments as Map),
        "/buyerPasswordReset":(context) => BuyerPasswordReset(arguments: ModalRoute.of(context)!.settings.arguments as Map),
        "/choose":(context) => Choose(),
        "/coderHome":(context) => CoderHome(),
        "/coderLogin": (context) => CoderLogin(),
        "/coderSignup":(context) => CoderSignup(),
        "/coderProjects":(context) => CoderProjects(),
        "/coderProfile":(context) => CoderProfile(),
        "/coderPayment":(context) => CoderPayment(),
        "/coderRequests":(context) => CoderRequests(),
        "/coderChatList":(context) => CoderChatList(),
        "/coderProjectBidders":(context) => CoderProjectBidders(arguments: ModalRoute.of(context)!.settings.arguments),
        "/coderExam":(context) => CoderExam(arguments: ModalRoute.of(context)!.settings.arguments),
        "/coderTechInfo":(context) => CoderTechInfo(arguments: ModalRoute.of(context)!.settings.arguments as Map),
        "/coderPasswordReset":(context) => CoderPasswordReset(arguments: ModalRoute.of(context)!.settings.arguments as Map)
      },
      initialRoute: "/choose",
    );
  }
}

