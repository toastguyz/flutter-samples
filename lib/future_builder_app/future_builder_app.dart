import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FutureBuilderApp extends StatefulWidget {
  @override
  _FutureBuilderAppState createState() => _FutureBuilderAppState();
}

class _FutureBuilderAppState extends State<FutureBuilderApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FutureBuilder App"),
      ),
      body: FutureBuilder<List<User>>(
        future: _getUserData(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var user = snapshot.data[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Center(
                        child: Text(
                          user.userName[0].toUpperCase(),
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    title: Text(user.userName),
                    subtitle: Text(
                      user.userDescription,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                      maxLines: 2,
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text("No Data Found"));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<User>> _getUserData() async {
    List<User> usersList = [];
    await Future.delayed(Duration(seconds: 5));
    var data = await http.get("https://navneet7k.github.io/sample_array.json");
    var jsonData = json.decode(data.body);

    for (var value in jsonData) {
      usersList.add(User.fromJson(value));
    }

    return usersList;
  }
}

class User {
  String userId;
  String userName;
  String userDescription;

  User(this.userId, this.userName, this.userDescription);

  User.fromJson(var value) {
    this.userId = value["id"];
    this.userName = value["name"];
    this.userDescription = value["desc"];
  }
}
