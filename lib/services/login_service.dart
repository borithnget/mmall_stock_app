import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:markarian_sales/model/login_model.dart';

String url="http://49.156.39.97:12220/api/Authenticate/login";

Future<http.Response> createLogin(Login login) async{
  final response=await http.post('$url',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      //HttpHeaders.authorizationHeader: ''
    },
    body: loginToJson(login)
  );
  return response;
}