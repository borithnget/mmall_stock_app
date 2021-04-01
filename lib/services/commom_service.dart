import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:markarian_sales/api/api.dart';
import 'package:markarian_sales/model/commom_model.dart';
import 'package:markarian_sales/model/inventory_model.dart';
import 'package:markarian_sales/model/sale_payment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:markarian_sales/model/login_model.dart';
import 'package:markarian_sales/model/common_response_model.dart';

Future<void> saveUserInfo(LoginResult user) async{
  print(jsonEncode(user));
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool result = await prefs.setString('user', jsonEncode(user));

}

Future<LoginResult> getUserInfo() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> userMap;
  final String userStr = prefs.getString('user');

  if (userStr != null) {
    userMap = jsonDecode(userStr) as Map<String, dynamic>;
  }
//print(userMap);
  if (userMap != null) {
    final LoginResult user = LoginResult.fromJson(userMap);
    //print(user.id);
    return user;
  }
  return null;
}

Future<http.Response> putSalePaymentResponse(PutSalePayment putSalePayment,String saleId) async{
  String url=Api.mainUrl+"Payment/Paid/"+saleId;
  print(url);
  final response = await http.put('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: putSalePaymentToJson(putSalePayment)
  );
  //print(putSalePaymentToJson(putSalePayment));
  return response;
}
Future<http.Response> putSaleDeleteResponse(PutSaleDeleteModel putSaleDeleteModel,String id) async{
  final url=Api.mainUrl+"Sale/Delete/$id";
  final response = await http.put('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: putSaleDelteToJson(putSaleDeleteModel)
  );

  return response;
}
Future<http.Response> putCartRemoveItemResponse(String id,PutCartRemoveItem putCartRemoveItem) async{
  final url=Api.mainUrl+"Cart/RemoveItemCart/$id";
  final response=await http.put('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: putCartRemoveItemToJson(putCartRemoveItem)
  );
  return response;
}


Future<http.Response> postProductCheckoutResponse(List<ProductCheckOut> productCheckouts) async{
  String url=Api.mainUrl+"Sale/CheckOut?pageSize=50&pageNumber=1";
  final response=await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(productCheckouts)
  );
  //print(response);
  return response;
}

Future<http.Response> postAddItemtoCartResponse(PostAddItemToCart postAddItemToCart) async{
  String url=Api.mainUrl+"Cart/AddToCart";
  final response=await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: postAddItemToCartJson(postAddItemToCart)
  );
  return response;
}

Future<http.Response> postSaleResponse(PostSaleModel postSaleModel) async{
  String url=Api.mainUrl+"Sale/Create";
  print(postSaleToJson(postSaleModel));
  final response=await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: postSaleToJson(postSaleModel)
  );
  //print(postSaleToJson(postSaleModel));
  return response;
}


Future<CheckOutProductResponse> getCartItembyUser(String id) async{
  final String url=Api.mainUrl+"Cart/CartItem?pageSize=50&pageNumber=1&userId=$id";
  print(url);
  final response=await http.get(url);
  print(response.body);
  return checkOutProductResponseFromJson(response.body);
}

Future<InventoryResponse> getStockBalance(int _pageSize,int _pageNumber) async{
  final String url=Api.mainUrl+"Stock/StockBalance?pageSize=$_pageSize&pageNumber=$_pageNumber";
  final response=await http.get(url);
  return inventoryFromJson(response.body);
}
Future<InventoryResponse> getStockBalanceByAutoSuggust(int _pageSize,int _pageNumber,String term) async{
  final String url=Api.mainUrl+"Stock/ProductAutoSuggestName?term=$term&pageSize=$_pageSize&pageNumber=$_pageNumber";
  final response=await http.get(url);
  return inventoryFromJson(response.body);
}

Future<OrderPlatformResponse> getOrderPlatformResponse() async{
  final url =Api.mainUrl+"GeneralSetting/OrderPlatform?pageSize=50&pageNumber=1";
  final response=await http.get(url);
  return orderPlatformResponseFromJson(response.body);
}

Future<OrderPlatformDetailResponse> getOrderPlatformDetailResponse() async{
  final String url=Api.mainUrl+"GeneralSetting/OrderPlatformDetail?pageSize=10&pageNumber=1";
  final response=await http.get(url);
  return orderPlatformDetailResponseFromJson(response.body);
}

Future<ProductDetailResponse> getProductDetailResponse(String id,String productDetailId) async{
  final String url=Api.mainUrl+"ProductSetting/ItemDetail/$id?product_detail=$productDetailId";
  final response=await http.get(url);
  return productDetailResponseFromJson(response.body);
}

Future<SaleInitialPage2Response> getSaleInitialPage2Response() async{
  final String url=Api.mainUrl+"Sale/SaleInitialPage2";
  final response=await http.get(url);
  return saleInitialPage2ResponseFromJson(response.body);
}
Future<SaleInitialPage3Response> getSaleInititalPage3Reseponse() async{
  final String url=Api.mainUrl+"Sale/SaleInitialPage3";
  final response=await http.get(url);
  return saleInitialPage3ResponseFromJson(response.body);
}
Future<SaleDetailResponse> getSaleDetailResponse(String id) async{
  final url=Api.mainUrl+"Sale/Detail/$id";
  final response=await http.get(url);
  //print(response.body);
  return saleDetailResponseFromJson(response.body);
}
Future<EmployeeModelResponse> getEmployeeDetailbyUserIdResponse(String id) async{
  final url=Api.mainUrl+"Account/Detail/$id";
  print(url);
  final response=await http.get(url);
  print(response.body);
  return employeeModelResponseFromJson(response.body);
}