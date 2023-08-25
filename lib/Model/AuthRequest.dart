import 'dart:core';

import 'dart:core';

class AuthRequest {
  String email;
  String password;
  AuthRequest({this.email,this.password});
  get getPassword => this.password;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  set setPassword(password) => this.password = password;


  AuthRequest.fromJson(Map<String,dynamic> json){
    this.password = json['password'];
    this.email = json['email'];
  }
  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
  @override
  String toString() {
    return "{\"email\":\"" +email+"\",\"password\":\"" +password+ "\"}";
  }

}