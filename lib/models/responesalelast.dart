// To parse this JSON data, do
//
//     final responeSaleLast = responeSaleLastFromJson(jsonString);

import 'dart:convert';

ResponeSaleLast responeSaleLastFromJson(String str) =>
    ResponeSaleLast.fromJson(json.decode(str));

String responeSaleLastToJson(ResponeSaleLast data) =>
    json.encode(data.toJson());

class ResponeSaleLast {
  ResponeSaleLast({
    this.message,
    this.didError,
    this.errorMessage,
    this.model,
    this.pageSize,
    this.pageNumber,
    this.itemsCount,
    this.pageCount,
  });

  String message;
  bool didError;
  dynamic errorMessage;
  List<ListSaleModel> model;
  int pageSize;
  int pageNumber;
  int itemsCount;
  double pageCount;

  factory ResponeSaleLast.fromJson(Map<String, dynamic> json) =>
      ResponeSaleLast(
        message: json["message"],
        didError: json["didError"],
        errorMessage: json["errorMessage"],
        model: List<ListSaleModel>.from(
            json["model"].map((x) => ListSaleModel.fromJson(x))),
        pageSize: json["pageSize"],
        pageNumber: json["pageNumber"],
        itemsCount: json["itemsCount"],
        pageCount: json["pageCount"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "didError": didError,
        "errorMessage": errorMessage,
        "model": List<dynamic>.from(model.map((x) => x.toJson())),
        "pageSize": pageSize,
        "pageNumber": pageNumber,
        "itemsCount": itemsCount,
        "pageCount": pageCount,
      };
}

class ListSaleModel {
  ListSaleModel({
    this.id,
    this.customerId,
    this.description,
    this.createdDate,
    this.updatedDate,
    this.status,
    this.saleCode,
    this.owe,
    this.invoiceStatus,
    this.invoiceNo,
    this.discount,
    this.amount,
    this.revicedFromCustomer,
    this.customerLocation,
    this.invoiceId,
    this.createdBy,
    this.updatedBy,
    this.saleNumber,
    this.discountType,
    this.discountType1,
    this.saleStatus,
    this.deliveryAmount,
    this.paymentTypeId,
    this.exchangeRate,
    this.receivedInReal,
    this.saleDatetime,
    this.orderPlatformId,
    this.orderPlatformDetailId,
    this.amountAdjustmentUsd,
    this.amountAdjustmentReal,
    this.totalAmount,
    this.totalAmountKhr,
    this.totalOutstandingUsd,
    this.totalOutstandingKhr,
    this.strTotalAmount,
    this.strCreatedDate,
    this.strShowStatus,
    this.customerName,
  });

  String id;
  String customerId;
  dynamic description;
  dynamic createdDate;
  dynamic updatedDate;
  dynamic status;
  dynamic saleCode;
  dynamic owe;
  dynamic invoiceStatus;
  dynamic invoiceNo;
  dynamic discount;
  dynamic amount;
  dynamic revicedFromCustomer;
  dynamic customerLocation;
  dynamic invoiceId;
  dynamic createdBy;
  dynamic updatedBy;
  String saleNumber;
  dynamic discountType;
  dynamic discountType1;
  SaleStatus saleStatus;
  dynamic deliveryAmount;
  dynamic paymentTypeId;
  dynamic exchangeRate;
  dynamic receivedInReal;
  dynamic saleDatetime;
  dynamic orderPlatformId;
  dynamic orderPlatformDetailId;
  dynamic amountAdjustmentUsd;
  dynamic amountAdjustmentReal;
  dynamic totalAmount;
  dynamic totalAmountKhr;
  dynamic totalOutstandingUsd;
  dynamic totalOutstandingKhr;
  String strTotalAmount;
  String strCreatedDate;
  StrShowStatus strShowStatus;
  dynamic customerName;

  factory ListSaleModel.fromJson(Map<String, dynamic> json) => ListSaleModel(
        id: json["id"],
        customerId: json["customerId"],
        description: json["description"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        status: json["status"],
        saleCode: json["saleCode"],
        owe: json["owe"],
        invoiceStatus: json["invoiceStatus"],
        invoiceNo: json["invoiceNo"],
        discount: json["discount"],
        amount: json["amount"],
        revicedFromCustomer: json["revicedFromCustomer"],
        customerLocation: json["customerLocation"],
        invoiceId: json["invoiceId"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        saleNumber: json["saleNumber"],
        discountType: json["discountType"],
        discountType1: json["discountType1"],
        saleStatus: saleStatusValues.map[json["saleStatus"]],
        deliveryAmount: json["deliveryAmount"],
        paymentTypeId: json["paymentTypeId"],
        exchangeRate: json["exchangeRate"],
        receivedInReal: json["receivedInReal"],
        saleDatetime: json["saleDatetime"],
        orderPlatformId: json["orderPlatformId"],
        orderPlatformDetailId: json["orderPlatformDetailId"],
        amountAdjustmentUsd: json["amountAdjustmentUsd"],
        amountAdjustmentReal: json["amountAdjustmentReal"],
        totalAmount: json["totalAmount"],
        totalAmountKhr: json["totalAmountKHR"],
        totalOutstandingUsd: json["totalOutstandingUSD"],
        totalOutstandingKhr: json["totalOutstandingKHR"],
        strTotalAmount: json["strTotalAmount"],
        strCreatedDate: json["strCreatedDate"],
        strShowStatus: strShowStatusValues.map[json["strShowStatus"]],
        customerName: json["customerName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerId": customerId,
        "description": description,
        "createdDate": createdDate,
        "updatedDate": updatedDate,
        "status": status,
        "saleCode": saleCode,
        "owe": owe,
        "invoiceStatus": invoiceStatus,
        "invoiceNo": invoiceNo,
        "discount": discount,
        "amount": amount,
        "revicedFromCustomer": revicedFromCustomer,
        "customerLocation": customerLocation,
        "invoiceId": invoiceId,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "saleNumber": saleNumber,
        "discountType": discountType,
        "discountType1": discountType1,
        "saleStatus": saleStatusValues.reverse[saleStatus],
        "deliveryAmount": deliveryAmount,
        "paymentTypeId": paymentTypeId,
        "exchangeRate": exchangeRate,
        "receivedInReal": receivedInReal,
        "saleDatetime": saleDatetime,
        "orderPlatformId": orderPlatformId,
        "orderPlatformDetailId": orderPlatformDetailId,
        "amountAdjustmentUsd": amountAdjustmentUsd,
        "amountAdjustmentReal": amountAdjustmentReal,
        "totalAmount": totalAmount,
        "totalAmountKHR": totalAmountKhr,
        "totalOutstandingUSD": totalOutstandingUsd,
        "totalOutstandingKHR": totalOutstandingKhr,
        "strTotalAmount": strTotalAmount,
        "strCreatedDate": strCreatedDate,
        "strShowStatus": strShowStatusValues.reverse[strShowStatus],
        "customerName": customerName,
      };
}

enum SaleStatus { CREATED }

final saleStatusValues = EnumValues({"created": SaleStatus.CREATED});

enum StrShowStatus { EMPTY }

final strShowStatusValues =
    EnumValues({"កំពុងរង់ចាំស្តុករៀបចំទំនិញ": StrShowStatus.EMPTY});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
