import 'dart:convert';
import 'package:apis/Covid19_app/CountriesModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class Apis{

  final List <CountriesModel> countries = [];

  String mainApi = 'https://disease.sh/v3/covid-19/';
  final String allData = 'https://disease.sh/v3/covid-19/all';
  final String allCountries = 'https://disease.sh/v3/covid-19/countries';

  Future<List<dynamic>> getCountry () async {
    final response = await https.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    var data ;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
      }
    return data;
    }

  }

