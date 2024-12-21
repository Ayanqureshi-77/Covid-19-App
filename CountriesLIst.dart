import 'dart:convert';
import 'package:apis/Covid19_app/Api.dart';
import 'package:apis/Covid19_app/CountriesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as https;

import 'Countrydata.dart';

class CountriesLIst extends StatefulWidget {
  const CountriesLIst({super.key});
  @override
  State<CountriesLIst> createState() => _CountriesLIstState();
}

class _CountriesLIstState extends State<CountriesLIst> {

  final searchControl = TextEditingController();
  Apis apis = Apis();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey.shade900,
      ),
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                setState(() {
                });
              },
              controller: searchControl,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.grey
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                hintText: 'Search by country'
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder(
                  future: apis.getCountry(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return  Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                           strokeWidth: 5,
                          ),
                        ),
                      );
                    } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (searchControl.text.isEmpty) {
                           return InkWell(
                             onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context) => Countrydata(
                                 name: snapshot.data![index]['country'],
                                 images: snapshot.data![index]['countryInfo']['flag'],
                                 active: snapshot.data![index]['active'],
                                 deaths: snapshot.data![index]['deaths'],
                               )));
                             },
                             child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(
                                    snapshot.data![index]['countryInfo']['flag'],
                                  ),
                                ),
                                title: Text(snapshot.data![index]['country'], style: TextStyle(
                                    fontFamily: 'poopins', color: Colors.white
                                ),),
                                subtitle: Text(snapshot.data![index]['cases'].toString(), style: TextStyle(
                                    fontFamily: 'poopins', color: Colors.grey
                                ),),
                              ),
                           );
                          }
                       else if (name.toLowerCase().contains(searchControl.text.toLowerCase())) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Countrydata(
                                  name: snapshot.data![index]['country'],
                                  images: snapshot.data![index]['countryInfo']['flag'],
                                  active: snapshot.data![index]['active'],
                                  deaths: snapshot.data![index]['deaths'],
                                )));
                              },
                              child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(
                                    snapshot.data![index]['countryInfo']['flag'],
                                  ),
                                ),
                                title: Text(snapshot.data![index]['country'], style: TextStyle(
                                    fontFamily: 'poopins', color: Colors.white
                                ),),
                                subtitle: Text(snapshot.data![index]['cases'].toString(), style: TextStyle(
                                    fontFamily: 'poopins', color: Colors.grey
                                ),),
                              ),
                            );
                          } else {
                           return Container();
                          }
                    });
                  }}),
            ),
          ],
        ),
      ),
    );
  }
}


