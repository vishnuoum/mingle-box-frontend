import 'package:flutter/material.dart';

class BuyerChat extends StatefulWidget {
  const BuyerChat({Key? key}) : super(key: key);

  @override
  _BuyerChatState createState() => _BuyerChatState();
}

class _BuyerChatState extends State<BuyerChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
    );
  }
}
