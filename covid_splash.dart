import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'CovidHome.dart';
import 'CovidModels.dart';
import 'package:http/http.dart' as http;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{


  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => CovidHome())));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Container(
                   height: 150,
                   width: 150,
                   child: Image.asset('images/Virus.png')
              ),
             SizedBox(height: 10,),
             Text('   Covid 19 \nTracker App',style: TextStyle(color: Colors.white,
                 fontSize: 24, fontFamily: 'poppins'), )
            ],
          ),
        ),
      ),
    );
  }
}
