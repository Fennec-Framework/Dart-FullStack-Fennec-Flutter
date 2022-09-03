import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/user.dart';

class ApiRepository {
  final Dio _dio = Dio();
  final String baseUrl = 'http://192.168.0.116:8080';
  final box = Hive.box("SecureBox");

  Future<User?> signup(String username, String email, String password,
      BuildContext context) async {
    var data = {'email': email, 'user_name': username, 'password': password};
    try {
      Response userData = await _dio.post('$baseUrl/auth/signup', data: data);
      Map<String, dynamic> response = jsonDecode(userData.data);
      const snackBar = SnackBar(
        content: Text('user sucessful registred'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return User.fromJson(response);
    } catch (e) {
      var snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return null;
    }
  }

  Future<User?> signin(
      String email, String password, BuildContext context) async {
    var data = {'email': email, 'password': password};
    try {
      Response userData = await _dio.post('$baseUrl/auth/signin', data: data);
      await box.put('token', userData.data['token']);
      Map<String, dynamic> response = jsonDecode(userData.data);
      const snackBar = SnackBar(
        content: Text('user successful logged in'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return User.fromJson(response);
    } catch (e) {
      var snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return null;
    }
  }
}
