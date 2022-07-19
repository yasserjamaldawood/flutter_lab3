import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'card_details.dart';

class UsersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserScreenState();
  }
}

class _UserScreenState extends State<UsersScreen> {
  late Future<List<User>> user;

  @override
  void initState() {
    super.initState();
    user = RemoteDataSource().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var _users = (snapshot.data as List<User>);
              return ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) => UserListItem(_users[index]));
            } else if (snapshot.hasError) {
              return Container(
                child: Center(child: Text('has error')),
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class UserListItem extends StatelessWidget {
  var _user;

  UserListItem(this._user);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width ,

      child: Center(
          child: InkWell(
        child: Card(
          child: Row(
            children: [
              Container(
                child: Image.network(
                  _user.picture,
                  fit: BoxFit.cover,
                      height: 100.0,
                      width: 100.0,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_user.title),
                  Text(_user.content),
                ],
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => cardDetailsScrean(userDetails: _user),
            ),
          );
        },
      )),
    );
  }
}

//data layer
class User {
  String title;
  String picture;
  String content;
  String id;

  User(
    this.title,
    this.picture,
    this.content,
    this.id,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
      json['title'],
      json['picture'],
      json['content'],
      json['id'],
    );
  }
}

class UsersUsecase {}

class RemoteDataSource {
  Future<List<User>> fetchUsers() async {
    var response = await http.get(
        Uri.parse('https://62d4154fcd960e45d452f790.mockapi.io/api/article'));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      var list = (jsonResponse as List);
      var newList = list.map((item) => User.fromJson(item)).toList();

      return newList;
    } else {
      throw Exception('Can not fetch user');
    }
  }
}
