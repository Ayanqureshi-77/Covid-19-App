import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../getModel/UserModel.dart';

class HomescreenUser extends StatefulWidget {
  const HomescreenUser({super.key});

  @override
  State<HomescreenUser> createState() => _HomescreenUserState();
}

class _HomescreenUserState extends State<HomescreenUser> {

  List <UserModel> userList = [];

  Future <List<UserModel>> getUser() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }
    else {
      return userList;
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
        body: FutureBuilder (
          future: getUser(),
          builder: (context, AsyncSnapshot <List<UserModel>> snapshot) {
            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context,  index) {
              return Expanded(
                child: Card(
                  child: ListTile(
                    title: Text(snapshot.data![index].email.toString()),
                    subtitle: Text(snapshot.data![index].address!.geo!.lat.toString()),
                  ),
                ),
              );
            });
          },
        )
    );
  }
}
