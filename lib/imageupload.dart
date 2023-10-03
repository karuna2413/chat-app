import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class Imageupload extends StatefulWidget {
   Imageupload({required this.onclick});
  final void Function (File pickimg) onclick;
  @override
  State<Imageupload> createState() => _ImageuploadState();
}

class _ImageuploadState extends State<Imageupload> {
  File ?pickedimg;
  void pickimg()async{
   var pickedimg1=await ImagePicker().pickImage(source: ImageSource.camera,maxWidth: 150,imageQuality: 50);
 if(pickedimg1==null)
   {
     return;
   }
   setState(() {
   pickedimg=File(pickedimg1.path);
 });
 widget.onclick(pickedimg!);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
           backgroundColor: Colors.deepPurpleAccent,
           foregroundImage: pickedimg!=null?FileImage(pickedimg!):null,
          radius: 50,

        ),
        TextButton.icon(onPressed: pickimg, icon: Icon(Icons.image), label: Text('add image'))
      ],
    );
  }
}
