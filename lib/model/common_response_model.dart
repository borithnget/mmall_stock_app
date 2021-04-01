import 'dart:convert';
import 'dart:io';

import 'package:markarian_sales/model/commom_model.dart';
import 'package:markarian_sales/model/product_model.dart';

class OrderPlatformResponse
{
  int itemsCount;
  int pageSize;
  List<OrderPlatform> model;

  OrderPlatformResponse({
    this.itemsCount,
    this.pageSize,
    this.model
  });

  factory OrderPlatformResponse.fromJson(Map<String,dynamic> json)=>OrderPlatformResponse(
      itemsCount:json["itemsCount"],
      pageSize: json["pageSize"],
      model:List<OrderPlatform>.from(json["model"].map((x)=>OrderPlatform.fromJson(x)))
  );

  Map<String,dynamic> toJson()=>{
    "itemsCount":itemsCount,
    "pageSize":pageSize,
    "model":List<dynamic>.from(model.map((x)=>toJson()))
  };

}

class OrderPlatformDetailResponse{
  int itemsCount;
  int pageSize;
  List<OrderPlatformDetail> model;

  OrderPlatformDetailResponse({
    this.itemsCount,
    this.pageSize,
    this.model
  });

  factory OrderPlatformDetailResponse.fromJson(Map<String,dynamic> json)=>OrderPlatformDetailResponse(
      itemsCount:json["itemsCount"],
      pageSize: json["pageSize"],
      model:List<OrderPlatformDetail>.from(json["model"].map((x)=>OrderPlatformResponse.fromJson(x)))
  );

  Map<String,dynamic> toJson()=>{
    "itemsCount":itemsCount,
    "pageSize":pageSize,
    "model":List<dynamic>.from(model.map((x)=>toJson()))
  };
}

class CheckOutProductResponse{
  //dynamic itemsCount;
  int pageSize;
  List<Product> model;
  dynamic pageNumber;
  dynamic pageCount;
  CheckOutProductResponse({
    //this.itemsCount,
    this.pageSize,
    this.model,
    this.pageNumber,
    this.pageCount
  });
  factory CheckOutProductResponse.fromJson(Map<String,dynamic> json)=>CheckOutProductResponse(
      //itemsCount:json["itemsCount"],
      pageSize: json["pageSize"],
      model:List<Product>.from(json["model"].map((x)=>Product.fromJson(x))),
    pageNumber: json["pageNumber"],
    pageCount: json["pageCount"]
  );

  Map<String,dynamic> toJson()=>{
    //"itemsCount":itemsCount,
    "pageSize":pageSize,
    "model":List<dynamic>.from(model.map((x)=>toJson())),
    "pageNumber":pageNumber,
    "pageCount":pageCount
  };
}

class ProductDetailResponse{
  bool didError;
  Product model;
  ProductDetailResponse({
    this.didError,
    this.model
  });
  factory ProductDetailResponse.fromJson(Map<String,dynamic> json)=>ProductDetailResponse(
    didError: json["didError"],
    model: Product.fromJson(json["model"])
  );
}

class SaleInitialPage2Response{
  bool didError;
  SaleInititalPage2 model;
  SaleInitialPage2Response({
    this.didError,
    this.model,
  });
  factory SaleInitialPage2Response.fromJson(Map<String,dynamic> json)=>SaleInitialPage2Response(
      didError: json["didError"],
      model: SaleInititalPage2.fromJson(json["model"])
  );
}
class SaleInitialPage3Response{
  bool didError;
  SaleInititalPage3 model;
  SaleInitialPage3Response({
    this.didError,
    this.model,
  });

  factory SaleInitialPage3Response.fromJson(Map<String,dynamic> json)=>SaleInitialPage3Response(
      didError: json["didError"],
      model: SaleInititalPage3.fromJson(json["model"])
  );
}
class EmployeeModelResponse{
  //bool didError;
  EmployeeModel model;

  EmployeeModelResponse({
   //this.didError,
   this.model
  });
  factory EmployeeModelResponse.fromJson(Map<String,dynamic> json)=>EmployeeModelResponse(
    //didError: json["didError"],
    model: EmployeeModel.fromJson(json["model"])
  );
}

OrderPlatformResponse orderPlatformResponseFromJson(String str){
  final jsonData=json.decode(str);
  return OrderPlatformResponse.fromJson(jsonData);
}
CheckOutProductResponse checkOutProductResponseFromJson(String str){
  final jsonData=json.decode(str);
  return CheckOutProductResponse.fromJson(jsonData);
}
OrderPlatformDetailResponse orderPlatformDetailResponseFromJson(String str){
  final jsonData=json.decode(str);
  return OrderPlatformDetailResponse.fromJson(jsonData);
}
ProductDetailResponse productDetailResponseFromJson(String str){
  final jsonData=json.decode(str);
  return ProductDetailResponse.fromJson(jsonData);
}
SaleInitialPage2Response saleInitialPage2ResponseFromJson(String str){
  final jsonData=json.decode(str);
  return SaleInitialPage2Response.fromJson(jsonData);
}
SaleInitialPage3Response saleInitialPage3ResponseFromJson(String str){
  final jsonData=json.decode(str);
  return SaleInitialPage3Response.fromJson(jsonData);
}
EmployeeModelResponse employeeModelResponseFromJson(String str){
  final jsonData=json.decode(str);
  return EmployeeModelResponse.fromJson(jsonData);
}


