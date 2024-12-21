import 'package:apis/postApi/Homescreen.dart';
import 'package:apis/postApi/image_postApi.dart';
import 'package:flutter/material.dart';
import 'Covid19_app/CountriesLIst.dart';
import 'Covid19_app/CovidHome.dart';
import 'Covid19_app/covid_splash.dart';
import 'getApi/Homescreen.dart';
import 'getApi/Homescreen_photos.dart';
import 'getApi/api_without_array.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
         bodyLarge: TextStyle(color: Colors.purple),
          bodySmall: TextStyle(color: Colors.purple),
        )
      ),
      home: SplashScreen(),
    );
  }}