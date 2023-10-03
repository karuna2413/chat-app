import 'package:chatapp/writemsg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chatmsg.dart';
class Chatscreen extends StatelessWidget {
  const Chatscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        title: Text('chat screen'),
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Chatmsg()),
          Writemsg()
        ],
      )
    );
  }
}
