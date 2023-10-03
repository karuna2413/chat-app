import 'package:chatapp/imageupload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
final firebase=FirebaseAuth.instance;//create obj of firebase sdk
class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  var islogin=true;
  var email='';
  var password='';
  File ?selectedimg;
  var isauth=false;
  var globalkey = GlobalKey<FormState>();

  void setvalidate() async {
    if (globalkey.currentState!.validate()) {
      globalkey.currentState!.save();


if(!islogin&&selectedimg==null)
  {
    return;
  }
setState(() {
  isauth=true;
});
    if (islogin) {
      try {
        final userlog = await firebase.signInWithEmailAndPassword(
            email: email, password: password);
        print(userlog);
      }
      on FirebaseAuthException catch (err) {
        if (err.code == 'user-not-found') {
          }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.message ?? 'failed authentication')),);
        setState(() {
          isauth=false;
        });

      }
    }
    else {
      try {
        final usersign = await firebase.createUserWithEmailAndPassword(
            email: email, password: password);
        final storagefolder= FirebaseStorage.instance.ref().child('user-img').child('${usersign.user!.uid}.jpg');
        await storagefolder.putFile(selectedimg!);
        final imgurl= await storagefolder.getDownloadURL();
        print(usersign);
        FirebaseFirestore.instance.collection('user').doc(usersign.user!.uid).set({
          'email':email,
          'username':'karuna24',
          'img':imgurl
        });
      }

      on FirebaseAuthException catch (err) {
        if (err.code == 'email-already-in-use') {}
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.message ?? 'failed authentication')),);
      }
      setState(() {
        isauth=false;
      });
    }
  }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Text('chat app'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 100,

                  // color: Colors.purple,
                  child: Image.asset('img/chat.png',width: 50,height: 50,),
                ),


            Card(
              child: SingleChildScrollView(
                child: Form(
                  key: globalkey,
                  child: Column(
                    children: [
                      if(!islogin)Imageupload(onclick: (pickimg){
                        selectedimg=pickimg;
                      },),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(labelText: "email"),
                        validator: (value) {
                          if (value == '') {
                            return 'required';
                          }

                          if (value!.trim().length > 20) {
                            return 'name should be less than 20 characters';
                          }


                          return null;
                        },
                        onSaved: (value) {
                          email = value!;
                        },
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text('Password'),
                        ),
                        validator: (value) {
                          // var pass = value;
                          var regv =
                          RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
                          if (value == '') {
                            return 'required';
                          }
                          if (value!.trim().length < 6) {
                            return 'password should be greater than 6 characters';
                          }
                          if (value!.trim().length > 12) {
                            return 'password should be less than 12 characters';
                          }
                          if (!regv.hasMatch(value)) {
                            return 'password must include special character,numbers,lower & uppercase characters';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          password = value!;
                        },
                      ),
                      isauth==true?CircularProgressIndicator():
                      ElevatedButton(
                          onPressed: () {

                            setvalidate();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer// Background color
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(islogin?'login':'Sign up'),
                          )),
                      TextButton(onPressed: (){
                        setState(() {
                          islogin=!islogin;

                        });
                      }, child: Text(islogin?'create a account':'i already have an account'))
                    ],
                  ),
                ),
              ),
            ),
      ]),
          ),
        ),
    ), );
  }
}
