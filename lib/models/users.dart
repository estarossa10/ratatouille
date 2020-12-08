import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ratatouille/database/database.dart';
import 'package:sqflite/sqflite.dart';

class Users {
  final String userID, Email, Username, Name, Phone, Address, LastLogin;

  Users(this.userID, this.Username, this.Email, this.Name, this.Phone, this.Address, this.LastLogin);

  Future<Users> login(String email, String password) async {
    final DatabaseProvider  =
    var bytes = utf8.encode(password);
    var hashed_pass = sha256.convert(bytes);
  }

}