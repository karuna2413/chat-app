import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Writemsg extends StatefulWidget {
  const Writemsg({super.key});

  @override
  State<Writemsg> createState() => _WritemsgState();
}

class _WritemsgState extends State<Writemsg> {
  void msgauth()async
  {
if(textcntrl.text.trim().isEmpty)
  {
return;
  }
final user=FirebaseAuth.instance.currentUser;
//get current sign up user
final userdata=await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();
//get exixting data using get methode
FirebaseFirestore.instance.collection('chat').add({//add nethode auto generate unique id
  'chat':textcntrl.text,
  'timestamp':Timestamp.now(),
  'username':userdata.data()!['email'], //send previous data to new chat msg
});
// Focus.of(context).unfocus();//remove keypad
textcntrl.clear();

  }
  var textcntrl=TextEditingController();
  @override
  void dispose() {
    textcntrl.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textcntrl,
            decoration: InputDecoration(labelText: "email"),

          ),
        ),
        IconButton(onPressed: msgauth, icon: Icon(Icons.send))
      ],
    );
  }
}
