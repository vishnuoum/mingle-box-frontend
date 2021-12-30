import 'package:flutter/material.dart';

class CoderChat extends StatefulWidget {
  const CoderChat({Key? key}) : super(key: key);

  @override
  _CoderChatState createState() => _CoderChatState();
}

class _CoderChatState extends State<CoderChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
    );
  }
}
