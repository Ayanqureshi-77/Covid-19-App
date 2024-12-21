import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import '../getApi/Homescreen.dart';

class imagepostApi extends StatefulWidget {
  const imagepostApi({super.key});

  @override
  State<imagepostApi> createState() => _imagepostApiState();
}

class _imagepostApiState extends State<imagepostApi> {

  File? image ;
  final picker = ImagePicker();

  Future pickImage () async{
    final pick = await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);

    if (pick != null) {
    setState(() {
      image = File(pick.path);
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('PostApi', style: TextStyle(color: Colors.white),),),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
             child: image == null ? Text('Pick Image')
                   : Container(
                    child: Center(
                      child: Image.file(
                          File(image!.path).absolute,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),

               ),
           )
           )],
             ),
      )
    );
  }
}

