import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class UserService extends ChangeNotifier{

  final String _baseUrl = "login-12df1-default-rtdb.firebaseio.com";
  bool isLoading = true;
  final List<User> users = [];
  final storage = FlutterSecureStorage();

  UserService(){
    getUsers();

  }

  Future < List<User> > getUsers() async{

    isLoading = true;
    notifyListeners();

    //keep the .json for the fetch
    final url = Uri.https(_baseUrl, "residentes.json",{
      'auth':await storage.read(key: "token")?? ""
    });

    //this give a Instance of Response 
    final resp = await http.get( url );
    // print(resp.body);
    // print(await storage.read(key: "token"));

    final Map<String, dynamic> UserMap = json.decode(resp.body);

    UserMap.forEach((key, value) {
      var user = User.fromMap(value);
      user.id = key;
      this.users.add(user);
    });

    isLoading = false;
    notifyListeners();

    return users;
  }

}