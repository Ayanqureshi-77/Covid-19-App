import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../getModel/Products.dart';

class HomescreenObject extends StatefulWidget {
  const HomescreenObject({super.key});

  @override
  State<HomescreenObject> createState() => _HomescreenObjectState();
}

class _HomescreenObjectState extends State<HomescreenObject> {

  Future <Products> getProduct() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/17ba1274-d76d-4240-bcb8-5252b7030142'));
    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      Products.fromJson(data);
    }
    return Products.fromJson(data);
  }

  bool favourite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('API', style: TextStyle(color: Colors.white),),
          ),
          backgroundColor: Colors.blue,
        ),
        body: FutureBuilder <Products>(
          future: getProduct(),
          builder: (context, AsyncSnapshot <Products> snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context,  index) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(snapshot.data!.data![index].shop!.name.toString()),
                          subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .3,
                            width: MediaQuery.of(context).size.width * 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.data![index].images!.length,
                                itemBuilder: (context,position) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                favourite = !favourite;
                                              });

                                            }, icon: favourite ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
                                        Container(
                                            height: MediaQuery.of(context).size.height * .2,
                                          width: MediaQuery.of(context).size.width * .5,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  snapshot.data!.data![index].images![position].url.toString(),
                                              )
                                            )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );}),
                          )
                        ),
                      ],
                    ),
                  );
                });
          },
        )
    );
  }
}
