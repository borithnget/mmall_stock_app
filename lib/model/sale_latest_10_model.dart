import 'dart:convert';

import 'package:markarian_sales/main.dart';
import 'package:markarian_sales/model/sale_detail_model.dart';

List<Sale> allSale(String str) {
  final jsonData = json.decode(str);
  return new List<Sale>.from(jsonData.map((x) => Sale.fromJson(x)));
}

SaleResponse saleLastest10FromJson(String str) {
  final jsonData = json.decode(str);
  return SaleResponse.fromJson(jsonData);
}

SalePaymentResponse salePaymentLatest10FromJson(String str) {
  final jsonData = json.decode(str);
  return SalePaymentResponse.fromJson(jsonData);
}

SaleCustomerLatest10 saleCustomerLatest10FromJson(String str) {
  final jsonData = json.decode(str);
  return SaleCustomerLatest10.fromJson(jsonData);
}

SaleResponse allSaleOutstandingPaymentFromJson(String str) {
  final jsonData = json.decode(str);
  return SaleResponse.fromJson(jsonData);
}

class SaleResponse {
  int itemsCount;
  List<Sale> model;
  dynamic pageSize;
  dynamic pageNumber;
  dynamic pageCount;

  SaleResponse(
      {this.itemsCount,
      this.model,
      this.pageSize,
      this.pageCount,
      this.pageNumber});

  factory SaleResponse.fromJson(Map<String, dynamic> json) => SaleResponse(
      itemsCount: json["itemsCount"],
      model: List<Sale>.from(json["model"].map((x) => Sale.fromJson(x))),
      pageNumber: json["pageNumber"],
      pageCount: json["pageCount"],
      pageSize: json["pageSize"]);

  Map<String, dynamic> toJson() => {
        "itemsCount": itemsCount,
        "model": List<dynamic>.from(model.map((x) => toJson())),
        "pageNumber": pageNumber,
        "pageCount": pageCount,
        "pageSize": pageSize
      };
}

class Sale {
  String id;
  String customerId;
  String saleNumber;
  String saleStatus;
  String strTotalAmount;
  String strCreatedDate;
  String strShowStatus;
  String invoiceNo;
  double totalAmount;
  double totalAmountKHR;
  double totalOutstandingUSD;
  double totalOutstandingKHR;
  String customerName;
  int totalDayExp;
  String createdDate;
  dynamic owe;
  dynamic amount;
  dynamic revicedFromCustomer;
  String orderPlatformName;
  String orderPlatformDetailName;
  String showSaleStatus;
  String strPaymentStatus;
  String soldBy;

  Sale({
    this.id,
    this.customerId,
    this.saleNumber,
    this.saleStatus,
    this.strTotalAmount,
    this.strCreatedDate,
    this.strShowStatus,
    this.invoiceNo,
    this.totalAmount,
    this.totalAmountKHR,
    this.totalOutstandingUSD,
    this.totalOutstandingKHR,
    this.customerName,
    this.totalDayExp,
    this.createdDate,
    this.owe,
    this.amount,
    this.revicedFromCustomer,
    this.orderPlatformName,
    this.orderPlatformDetailName,
    this.showSaleStatus,
    this.strPaymentStatus,
    this.soldBy,
  });
  factory Sale.fromJson(Map<String, dynamic> json) => new Sale(
        id: json["id"],
        customerId: json["customerId"],
        saleNumber: json["saleNumber"],
        saleStatus: json["saleStatus"],
        strTotalAmount: json["strTotalAmount"],
        strCreatedDate: json["strCreatedDate"],
        strShowStatus: json["strShowStatus"],
        invoiceNo: json["invoiceNo"],
        totalAmount: json["totalAmount"],
        totalAmountKHR: json["totalAmountKHR"],
        totalOutstandingUSD: json["totalOutstandingUSD"],
        totalOutstandingKHR: json["totalOutstandingKHR"],
        customerName: json["customerName"],
        totalDayExp: json["totalDayExp"],
        createdDate: json["createdDate"],
        owe: json["owe"],
        amount: json["amount"],
        revicedFromCustomer: json["revicedFromCustomer"],
        orderPlatformName: json["orderPlatformName"],
        orderPlatformDetailName: json["orderPlatformDetailName"],
        showSaleStatus: json["showSaleStatus"],
        strPaymentStatus: json["strPaymentStatus"],
        soldBy: json["soldBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerId": customerId,
        "saleNumber": saleNumber,
        "saleStatus": saleStatus,
        "strTotalAmount": strTotalAmount,
        "strCreatedDate": strCreatedDate,
        "strShowStatus": strShowStatus,
        "invoiceNo": invoiceNo,
        "totalAmount": totalAmount,
        "totalAmountKHR": totalAmountKHR,
        "totalOutstandingUSD": totalOutstandingUSD,
        "totalOutstandingKHR": totalOutstandingKHR,
        "customerName": customerName,
        "totalDayExp": totalDayExp,
        "createdDate": createdDate,
      };
}

class SalePayment {
  String salePaidId;
  String saleId;
  String saleNumber;
  String paidDate;
  double paidAmount;
  double paidAmountInReal;
  String createdBy;
  double exchangeRate;
  String customerId;
  String customerName;
  String strPaidData;

  SalePayment(
      {this.salePaidId,
      this.saleId,
      this.saleNumber,
      this.paidDate,
      this.paidAmount,
      this.paidAmountInReal,
      this.createdBy,
      this.exchangeRate,
      this.customerId,
      this.customerName,
      this.strPaidData});

  factory SalePayment.fromJson(Map<String, dynamic> json) => new SalePayment(
      salePaidId: json["salePaidId"],
      saleId: json["saleId"],
      saleNumber: json["saleNumber"],
      paidDate: json["paidDate"],
      paidAmount: json["paidAmount"],
      paidAmountInReal: json["paidAmountInReal"],
      createdBy: json["createdBy"],
      exchangeRate: json["exchangeRate"],
      customerId: json["customerId"],
      customerName: json["customerName"],
      strPaidData: json["strPaidData"]);

  Map<String, dynamic> toJson() => {
        "salePaidId": salePaidId,
        "saleId": saleId,
        "saleNumber": saleNumber,
        "paidDate": paidDate,
        "paidAmount": paidAmount,
        "paidAmountInReal": paidAmountInReal,
        "createdBy": createdBy,
        "exchangeRate": exchangeRate,
        "customerId": customerId,
        "customerName": customerName,
        "strPaidData": strPaidData
      };
}

class SalePaymentResponse {
  int itemsCount;
  int pageSize;
  int pageNumber;
  List<SalePayment> model;

  SalePaymentResponse({this.itemsCount, this.pageSize, this.model,this.pageNumber});
  factory SalePaymentResponse.fromJson(Map<String, dynamic> json) =>
      SalePaymentResponse(
          itemsCount: json["itemsCount"],
          pageSize: json["pageSize"],
          pageNumber: json["pageNumber"],
          model: List<SalePayment>.from(
              json["model"].map((x) => SalePayment.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "itemsCount": itemsCount,
        "pageSize": pageSize,
    "pageNumber":pageNumber,
        "model": List<dynamic>.from(model.map((x) => toJson()))
      };
}

class Customer {
  String id;
  String customerNo;
  String customerName;
  int totalOrders;
  double totalOrderAmounts;

  Customer({
    this.id,
    this.customerNo,
    this.customerName,
    this.totalOrders,
    this.totalOrderAmounts,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => new Customer(
        id: json["id"],
        customerNo: json["customerNo"],
        customerName: json["customerName"],
        totalOrders: json["totalOrders"],
        totalOrderAmounts: json["totalOrderAmounts"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerNo": customerNo,
        "customerName": customerName,
        "totalOrders": totalOrders,
        "totalOrderAmounts": totalOrderAmounts
      };
}

class SaleCustomerLatest10 {
  int itemsCount;
  int pageSize;
  List<Customer> model;

  SaleCustomerLatest10({this.itemsCount, this.pageSize, this.model});
  factory SaleCustomerLatest10.fromJson(Map<String, dynamic> json) =>
      SaleCustomerLatest10(
          itemsCount: json["itemsCount"],
          pageSize: json["pageSize"],
          model: List<Customer>.from(
              json["model"].map((x) => Customer.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "itemsCount": itemsCount,
        "pageSize": pageSize,
        "model": List<dynamic>.from(model.map((x) => toJson()))
      };
}
