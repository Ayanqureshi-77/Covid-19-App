import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../getApi/Homescreen.dart';

class PostHomescreen extends StatefulWidget {
  const PostHomescreen({super.key});

  @override
  State<PostHomescreen> createState() => _PostHomescreenState();
}

class _PostHomescreenState extends State<PostHomescreen> {

  final email = TextEditingController();
  final password = TextEditingController();
  final key = GlobalKey <FormState> ();
  bool isProgress = false;
  
   void postApi (String email, password) async{
     try {
      final response = await post(Uri.parse('https://reqres.in/api/login'),
           body : {
             'email' : email.toString(),
             'password' : password.toString()
           });
       if (response.statusCode == 200) {
         print('Success');
       } else {
         print('FAiled');
       }
     } catch (e) {
       print(e.toString());
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('PostApi', style: TextStyle(color: Colors.white),),),
        backgroundColor: Colors.blue,
      ),
      body:
      Form(
        key: key,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: 'Email'
                ),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Error write any email';
                  } else {
                    value = email.text.toString();
                  }
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: password,
                decoration: InputDecoration(
                    hintText: 'password'
                ),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Error write any password';
                  } else {
                    value = password.text.toString();
                  }
                },
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  if (key.currentState!.validate()) {
                  postApi(email.text.toString(), password.text.toString());
                  }
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue
                  ),
                  child: Center(
                      child: isProgress ? CircularProgressIndicator() : Text('Login', style: TextStyle(color: Colors.white),)),
                ),
              ),
            ],

            ),
        ),
      ),
    );
  }
}

