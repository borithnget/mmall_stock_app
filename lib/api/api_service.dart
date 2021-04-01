import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:markarian_sales/model/commom_model.dart';
import 'dart:io';
import 'package:markarian_sales/model/repositiries_model.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';
import 'package:markarian_sales/services/commom_service.dart';

import 'api.dart';

Future<ItemsList> getRepositories() async {
  final response = await http.get('https://api.github.com/search/repositories?q=flutter',
    headers: {
      HttpHeaders.CONTENT_TYPE : 'application/json',
    },
  );
  //print(response.statusCode.toString() + "repo github");
  final responseJson = json.decode(response.body);
  return new ItemsList.fromJson(responseJson);
}

Future<List<SalePayment>> getSalePaids(String id) async{
  final String url=Api.mainUrl+"Payment/SalePaidByUser?pageSize=50&pageNumber=1&user_id="+id;
  final response=await http.get(url);
  print(response.body);
  SalePaymentResponse result= salePaymentLatest10FromJson(response.body);
  return result.model;
}

Future<SaleModel> getSaleDetailById(String id) async{
  final url=Api.mainUrl+"Sale/Detail/$id";
  print(url);
  final response=await http.get(url);
  //print(response.body);
  final result= saleDetailResponseFromJson(response.body);
  return result.model;
}
Future<List<Sale>> getSaleOutstandingPaymentByUser(String id) async {
  final String url = Api.mainUrl +"Payment/OutstandingByUser?pageSize=50&pageNumber=1&user_id=" + id;
  final response = await http.get(url);
  //print(response.body);
  final result= allSaleOutstandingPaymentFromJson(response.body);
  return result.model;
}

