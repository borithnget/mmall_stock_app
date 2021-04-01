import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:markarian_sales/api/api.dart';
import 'dart:async';
import 'dart:io';
import 'package:markarian_sales/model/sale_latest_10_model.dart';

//String url = 'http://49.156.39.97:12220/api/Dashboard/SaleLatest10?pageSize=10&pageNumber=1';
/*
Future<List<SaleLastest10>> getAllSaleLatest10() async {
  final response = await http.get(url);
  print(response.body);
  return allSaleLatest10sFromJson(response.body);
}*/
Future<SaleResponse> getSaleLatest10() async {
  final String url =
      Api.mainUrl + 'Dashboard/SaleLatest10?pageSize=10&pageNumber=1';
  final response = await http.get(url);
  //print(response.body);
  return saleLastest10FromJson(response.body);
}

Future<SaleResponse> getSaleListbyUserAndDateRange(
    String userId, String dateFrom, String dateTo) async {
  final String url = Api.mainUrl +
      "Sale/List?pageSize=50&pageNumber=1&DateFrom=$dateFrom&DateTo=$dateTo&UserId=$userId";
  final response = await http.get(url);
  return saleLastest10FromJson(response.body);
}
Future<SaleResponse> getSaleListbyFilterSaleNumberCustomername(String userId,String term) async{
  final String url=Api.mainUrl+"Sale/FilterBySaleNumberAndCustomerName?pageSize=50&pageNumber=1&term=$term&UserId=$userId";
  final response= await http.get(url);
  return saleLastest10FromJson(response.body);
}

Future<SaleResponse> getSaleOutstandingLatest10() async {
  final String url = Api.mainUrl + "Dashboard/SaleOutstandingPaymentLatest10";
  final response = await http.get(url);
  //print(response.body);
  return saleLastest10FromJson(response.body);
}

Future<SalePaymentResponse> getSalePaymentLatest10() async {
  final String url = Api.mainUrl + "Dashboard/SalePaymentLatest10";
  final response = await http.get(url);
  return salePaymentLatest10FromJson(response.body);
}

Future<SaleCustomerLatest10> getSaleCustomerLatest10() async {
  final String url = Api.mainUrl + "Dashboard/SaleCustomerLatest10";
  final response = await http.get(url);
  return saleCustomerLatest10FromJson(response.body);
}

Future<SaleResponse> getAllSaleOutstandingPaymentByUser(String id) async {
  final String url = Api.mainUrl +
      "Payment/OutstandingByUser?pageSize=50&pageNumber=1&user_id=" +
      id;
  final response = await http.get(url);
  //print(response.body);
  return allSaleOutstandingPaymentFromJson(response.body);
}

Future<SaleResponse> getAllSaleOutstandingPaymentOver3DaysByUser(
    String id) async {
  final String url = Api.mainUrl +
      "Payment/OutstandingOver3DaysByUser?pageSize=50&pageNumber=1&user_id=" +
      id;
  final response = await http.get(url);
  return allSaleOutstandingPaymentFromJson(response.body);
}

Future<SalePaymentResponse> getAllSalePaidByUser(String id) async {
  final String url = Api.mainUrl +
      "Payment/SalePaidByUser?pageSize=50&pageNumber=1&user_id=" +
      id;
  final response = await http.get(url);
  return salePaymentLatest10FromJson(response.body);
}
