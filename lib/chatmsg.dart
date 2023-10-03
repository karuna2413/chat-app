import 'package:flutter/material.dart';

class Chatmsg extends StatefulWidget {
  const Chatmsg({super.key});

  @override
  State<Chatmsg> createState() => _ChatmsgState();
}

class _ChatmsgState extends State<Chatmsg> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('no msg found'),
    );
  }
}
