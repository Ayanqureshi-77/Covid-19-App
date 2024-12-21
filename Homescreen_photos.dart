import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomescreenPhotos extends StatefulWidget {
  const HomescreenPhotos({super.key});

  @override
  State<HomescreenPhotos> createState() => _HomescreenPhotosState();
}

class _HomescreenPhotosState extends State<HomescreenPhotos> {
  
  List <Photos> photoList = [];
  
  Future<List<Photos>> getPhotos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photoList.add(photos);
      }
      return photoList;
    }else {
      return photoList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('API', style: TextStyle(color: Colors.white),),
          ),
          backgroundColor: Colors.blue,
        ),
        body: FutureBuilder(
          future: getPhotos(),
          builder: (context, snapshot) {
            return ListView.builder(itemBuilder: (context,  index) {
              return Expanded(
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        snapshot.data![index].url.toString(),
                      ),
                    ),
                    title: Text(snapshot.data![index].title.toString()),
                    subtitle: Text(snapshot.data![index].id.toString()),
                  ),
                ),
              );
            });
          },
        )
    );
  }

}

class Photos {

  String? title;
  String? url;
  int? id;

  Photos({required this.title, required this.url, required this.id});

}
