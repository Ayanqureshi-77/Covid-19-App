import 'dart:convert';

import 'package:apis/Covid19_app/CountriesLIst.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Api.dart';
import 'CovidHome.dart';
import 'CovidModels.dart';

class Countrydata extends StatelessWidget {

  Countrydata({required this.name, required this.images,
    required this.deaths, required this.active});

  final String name ;

  final String images ;

  late int deaths , active;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey.shade900,
      ),

      backgroundColor: Colors.grey.shade900,
      body:
      Column(
        children: [
          CircleAvatar(
            radius: 50,
              backgroundImage: NetworkImage(
            images,
          )),
          SizedBox(
            height: 30,
          ),
          Card(
            color: Colors.grey.shade800,
            child: Column(
              children: [
                Reusable(
                  title: 'Name', value: name),
                Reusable(
                    title: 'Active', value: deaths.toString()),
                Reusable(
                    title: 'Deaths', value: active.toString()),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
