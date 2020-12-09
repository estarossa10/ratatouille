import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ratatouille/database/database_helper.dart';
import 'package:ratatouille/models/users.dart';

class UserController {

  static Future<Users> login(String username, String password) {
    var bytes = utf8.encode(password);
    var hashed_pass = sha256.convert(bytes);
    return DatabaseHelper.instance.login(username, hashed_pass.toString());
  }

}