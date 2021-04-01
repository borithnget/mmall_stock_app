import 'dart:convert';

import 'package:markarian_sales/home/all_menu/our_order_and_make_new_order/our_order_and_make_new_order.dart';
import 'package:markarian_sales/model/sale_detail_model.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';

APIResponse apiResponseFromJson(String str){
  final jsonData=json.decode(str);
  return APIResponse.fromJson(jsonData);
}
SaleDetailResponse saleDetailResponseFromJson(String str){
  final jsonData=json.decode(str);
  return SaleDetailResponse.fromJson(jsonData);
}
SaleModel saleResponseFromJson(String str){
  final jsonData=json.decode(str);
  return SaleModel.fromJson(jsonData);
}

class APIResponse{
  String message;
  String errorMessage;
  bool didError;

  APIResponse({
    this.message,
    this.errorMessage,
    this.didError
});

  factory APIResponse.fromJson(Map<String,dynamic> json)=>new APIResponse(
    message: json["message"],
    errorMessage: json["errorMessage"],
    didError: json["didError"]
  );

  Map<String,dynamic> toJson()=>{
    "message":message,
    "errorMessage":errorMessage,
  };

}

class SaleDetailResponse{
  String message;
  String errorMessage;
  bool didError;
  SaleModel model;

  SaleDetailResponse({
    this.message,
    this.errorMessage,
    this.didError,
    this.model
  });

  factory SaleDetailResponse.fromJson(Map<String,dynamic> json)=>new SaleDetailResponse(
      message: json["message"],
      errorMessage: json["errorMessage"],
      didError: json["didError"],
    model:SaleModel.fromJson(json["model"]),
  );

  Map<String,dynamic> toJson()=>{
    "message":message,
    "errorMessage":errorMessage,
    "didError":didError,
    "model":model,
  };
}

class SaleModel{

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
  String description;

  dynamic discount;
  dynamic deliveryAmount;
  String paymentTypeId;
  dynamic exchangeRate;
  dynamic receivedInReal;
  String orderPlatformId;
  String orderPlatformDetailId;
  SDCustomer customer;
  String paymentTypeName;
  List<SaleDetail> saleDetails;
  List<SalePayment> salePayments;
  List<SDDelivery> saleDeliveries;
  List<SaleWorkflowModel> saleWorkflows;
  List<CustomerContactPhoneModel> customerContactPhones;
  SaleModel({
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
    this.discount,
    this.deliveryAmount,
    this.paymentTypeId,
    this.exchangeRate,
    this.receivedInReal,
    this.orderPlatformId,
    this.orderPlatformDetailId,
    this.customer,
    this.paymentTypeName,
    this.saleDetails,
    this.salePayments,
    this.saleDeliveries,
    this.saleWorkflows,
    this.customerContactPhones,
    this.description
  });
  factory SaleModel.fromJson(Map<String,dynamic> json)=>new SaleModel(
    id:json["id"],
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
    revicedFromCustomer:json["revicedFromCustomer"],
    orderPlatformName: json["orderPlatformName"],
    orderPlatformDetailName: json["orderPlatformDetailName"],
    showSaleStatus: json["showSaleStatus"],
    strPaymentStatus: json["strPaymentStatus"],
    soldBy: json["soldBy"],
    discount: json["discount"],
    deliveryAmount: json["deliveryAmount"],
    paymentTypeId: json["paymentTypeId"],
    exchangeRate: json["exchangeRate"],
    receivedInReal: json["receivedInReal"],
    orderPlatformId: json["orderPlatformId"],
    orderPlatformDetailId: json["orderPlatformDetailId"],
    paymentTypeName: json["paymentTypeName"],
    description: json["description"],
    customer: SDCustomer.fromJson(json["customer"]),
    saleDetails: List<SaleDetail>.from(json["saleDetails"].map((x)=>SaleDetail.fromJson(x))),
    saleDeliveries: List<SDDelivery>.from(json["saleDeliveries"].map((x)=>SDDelivery.fromJson(x))),
    salePayments: List<SalePayment>.from(json["salePayments"].map((x)=>SalePayment.fromJson(x))),
    saleWorkflows: List<SaleWorkflowModel>.from(json["saleWorkflows"].map((x)=>SaleWorkflowModel.fromJson(x))),
    customerContactPhones: List<CustomerContactPhoneModel>.from(json["customerContactPhones"].map((x)=>CustomerContactPhoneModel.fromJson(x))),
  );

  Map<String,dynamic> toJson()=>{
    "id":id,
    "customerId":customerId,
    "saleNumber":saleNumber,
    "saleStatus":saleStatus,
    "strTotalAmount":strTotalAmount,
    "strCreatedDate":strCreatedDate,
    "strShowStatus":strShowStatus,
    "invoiceNo":invoiceNo,
    "totalAmount":totalAmount,
    "totalAmountKHR":totalAmountKHR,
    "totalOutstandingUSD":totalOutstandingUSD,
    "totalOutstandingKHR":totalOutstandingKHR,
    "customerName":customerName,
    "totalDayExp":totalDayExp,
    "createdDate":createdDate,
    "discount":discount,
    "deliveryAmount":deliveryAmount,
    "paymentTypeId":paymentTypeId,
    "exchangeRate":exchangeRate,
    "receivedInReal":receivedInReal,
    "orderPlatformId":orderPlatformId,
    "orderPlatformDetailId":orderPlatformDetailId,
    "customer":customer,
    "paymentTypeName":paymentTypeName,
    "description":description,
    "saleDetails":List<dynamic>.from(saleDetails.map((x)=>toJson())),
    "salePayments":List<dynamic>.from(saleDeliveries.map((x)=>toJson())),
    "saleDeliveries":List<dynamic>.from(salePayments.map((x)=>toJson()))
  };

}

class ProductCheckOut{
  String ProductId;
  String ProductDetailId;
  String UnitId;

  ProductCheckOut({
    this.ProductId,
    this.ProductDetailId,
    this.UnitId
  });

  factory ProductCheckOut.fromJson(Map<String,dynamic> json)=>new ProductCheckOut(
    ProductId: json["ProductId"],
    ProductDetailId: json["ProductDetailId"],
    UnitId: json["UnitId"],
  );

  Map<String,dynamic> toJson()=>{
    "ProductId":ProductId,
    "ProductDetailId":ProductDetailId,
    "UnitId":UnitId
  };

}

class ProductCheckOutRequest{

}
class OrderPlatform{
  String orderPlatformId;
  String orderPlatfromName;
  bool isVisible;
  bool active;

  OrderPlatform({
   this.orderPlatformId,
   this.orderPlatfromName,
   this.isVisible,
   this.active
  });

  factory OrderPlatform.fromJson(Map<String,dynamic> json)=>new OrderPlatform(
    orderPlatformId: json["orderPlatformId"],
    orderPlatfromName: json["orderPlatfromName"],
    isVisible: json["isVisible"],
    active: json["active"]
  );

  Map<String,dynamic> toJson()=>{
    "orderPlatformId":orderPlatformId,
    "orderPlatfromName":orderPlatfromName,
    "isVisible":isVisible,
    "active":active
  };

}
class OrderPlatformDetail{
  String orderPlatformDetailId;
  String orderPlatfromId;
  String orderPlatformDetailName;
  bool isVisible;
  OrderPlatformDetail({
    this.orderPlatformDetailId,
    this.orderPlatfromId,
    this.orderPlatformDetailName,
    this.isVisible
  });
  factory OrderPlatformDetail.fromJson(Map<String,dynamic> json)=>new OrderPlatformDetail(
    orderPlatformDetailId: json["orderPlatformDetailId"],
    orderPlatfromId: json["orderPlatfromId"],
    orderPlatformDetailName: json["orderPlatformDetailName"],
    isVisible: json["isVisible"]
  );
  Map<String,dynamic> toJson()=>{
    "orderPlatformDetailId":orderPlatformDetailId,
    "orderPlatfromId":orderPlatfromId,
    "orderPlatformDetailName":orderPlatformDetailName,
    "isVisible":isVisible
  };
}
class SaleInititalPage2{
  String saleNumber;
  List<OrderPlatform> orderPlatforms;
  List<OrderPlatformDetail> orderPlatformDetails;
  SaleInititalPage2({
    this.saleNumber,
    this.orderPlatforms,
    this.orderPlatformDetails
  });
  factory SaleInititalPage2.fromJson(Map<String,dynamic> json)=>new SaleInititalPage2(
    saleNumber: json["saleNumber"],
    orderPlatforms: List<OrderPlatform>.from(json["orderPlatforms"].map((x)=>OrderPlatform.fromJson(x))),
    orderPlatformDetails: List<OrderPlatformDetail>.from(json["orderPlatformDetails"].map((x)=>OrderPlatformDetail.fromJson(x))),
  );
}
class DeliveryModel{
  String id;
  String shipperName;
  DeliveryModel({
   this.id,
    this.shipperName
});
  factory DeliveryModel.fromJson(Map<String,dynamic> json)=>new DeliveryModel(
    id: json["id"],
    shipperName: json["shipperName"]
  );
}
class PaymentTypeModel{
  String paymentTypeId;
  String paymentType;
  PaymentTypeModel({
   this.paymentTypeId,
   this.paymentType
});
  factory PaymentTypeModel.fromJson(Map<String,dynamic> json)=>new PaymentTypeModel(
    paymentTypeId: json["paymentTypeId"],
    paymentType: json["paymentType"]
  );
}
class SaleInititalPage3{
  List<PaymentTypeModel> paymentTypes;
  List<DeliveryModel> deliveries;
  SaleInititalPage3({
    this.paymentTypes,
    this.deliveries
  });
  factory SaleInititalPage3.fromJson(Map<String,dynamic> json)=>new SaleInititalPage3(
    paymentTypes: List<PaymentTypeModel>.from(json["paymentTypes"].map((x)=>PaymentTypeModel.fromJson(x))),
    deliveries: List<DeliveryModel>.from(json["deliveries"].map((x)=>DeliveryModel.fromJson(x)))
  );
}

class PostDeliveryModel{
  String DeliveryId;
  String DeliveryDate;
  String ContactPersonName;
  String ContactPersonPhone;
  PostDeliveryModel({
   this.DeliveryId,
   this.DeliveryDate,
   this.ContactPersonName,
   this.ContactPersonPhone
});
  factory PostDeliveryModel.fromJson(Map<String,dynamic> json)=>new PostDeliveryModel(
    DeliveryId: json["DeliveryId"],
    DeliveryDate: json["DeliveryDate"],
    ContactPersonName: json["ContactPersonName"],
    ContactPersonPhone: json["ContactPersonPhone"]
  );
  Map<String,dynamic> toJson()=>{
    "DeliveryId":DeliveryId,
    "DeliveryDate":DeliveryDate,
    "ContactPersonName":ContactPersonName,
    "ContactPersonPhone":ContactPersonPhone,
  };
}
class PostCustomerModel{
  String CustomerId;
  String CustomerName;
  String Address;
  List<String> ContactPhones;
  PostCustomerModel({
   this.CustomerId,
   this.CustomerName,
   this.Address,
   this.ContactPhones
});
  factory PostCustomerModel.fromJson(Map<String,dynamic> json)=>new PostCustomerModel(
    CustomerId: json["CustomerId"],
    CustomerName: json["CustomerName"],
    Address: json["Address"],
    //ContactPhones: List<String>.from(json["ContactPhones"].map((x)=>String.fromJson(x)))
  );
  Map<String,dynamic> toJson()=>{
    "CustomerId":CustomerId,
    "CustomerName":CustomerName,
    "Address":Address,
    "ContactPhones":ContactPhones
  };
}
class PostProductModel{
  String ProductId;
  dynamic Quantity;
  dynamic Price;
  String UnitTypeId;
  dynamic ActualPrice;
  dynamic DiscountAmount;
  dynamic DiscountPercentage;
  String ProductDetailId;

  PostProductModel( {
   this.ProductId,
   this.Quantity,
   this.Price,
   this.UnitTypeId,
   this.ActualPrice,
   this.DiscountAmount,
   this.DiscountPercentage,
   this.ProductDetailId,
});

  Map<String,dynamic> toJson()=>{
    "ProductId":ProductId,
    "Quantity":Quantity,
    "Price":Price,
    "UnitTypeId":UnitTypeId,
    "ActualPrice":ActualPrice,
    "DiscountAmount":DiscountAmount,
    "DiscountPercentage":DiscountPercentage,
    "ProductDetailId":ProductDetailId
  };
}

class PostSaleModel{
  String Id;
  String SaleDate;
  dynamic Amount;
  dynamic Discount;
  String DiscountType;
  dynamic ReceivedUSD;
  dynamic ReceivedKHR;
  dynamic DeliveryAmount;
  dynamic ExchangeRate;
  String Description;
  String PaymentTypeId;
  String OrderPlatformId;
  String OrderPlatformDetailId;
  String UserId;
  PostCustomerModel Customer;
  PostDeliveryModel Delivery;
  List<PostProductModel> Products;

  PostSaleModel({
   this.Id,
   this.SaleDate,
   this.Amount,
   this.Discount,
   this.DiscountType,
   this.ReceivedUSD,
    this.ReceivedKHR,
    this.DeliveryAmount,
    this.ExchangeRate,
    this.Description,
    this.PaymentTypeId,
    this.OrderPlatformId,
    this.OrderPlatformDetailId,
    this.UserId,
    this.Customer,
    this.Delivery,
    this.Products
});
  Map<String,dynamic> toJson()=>{
    "Id":Id,
    "SaleDate":SaleDate,
    "Amount":Amount,
    "Discount":Discount,
    "DiscountType":DiscountType,
    "ReceivedUSD":ReceivedUSD,
    "ReceivedKHR":ReceivedKHR,
    "DeliveryAmount":DeliveryAmount,
    "ExchangeRate":ExchangeRate,
    "Description":Description,
    "PaymentTypeId":PaymentTypeId,
    "OrderPlatformId":OrderPlatformId,
    "OrderPlatformDetailId":OrderPlatformDetailId,
    "UserId":UserId,
    "Customer":Customer.toJson(),
    "Delivery":Delivery.toJson(),
    "Products":Products
  };

}

class PostAddItemToCart{
  String ProductId;
  String ProductDetailId;
  String UnitTypeId;
  dynamic QtyBalance;
  dynamic Price;
  dynamic Discount;
  dynamic DiscountPercentage;
  String CreateBy;

  PostAddItemToCart({
   this.ProductId,
   this.ProductDetailId,
   this.UnitTypeId,
   this.QtyBalance,
   this.Price,
   this.Discount,
   this.DiscountPercentage,
   this.CreateBy
});

  Map<String,dynamic> toJson()=>{
    "ProductId":ProductId,
    "ProductDetailId":ProductDetailId,
    "UnitTypeId":UnitTypeId,
    "QtyBalance":QtyBalance,
    "Price":Price,
    "Discount":Discount,
    "DiscountPercentage":DiscountPercentage,
    "CreateBy":CreateBy
  };

}

class PutSaleDeleteModel{
  String SaleId;
  String Remark;
  String UserId;
  PutSaleDeleteModel({
   this.SaleId,
   this.Remark,
   this.UserId
});
  Map<String,dynamic> toJson()=>{
    "SaleId":SaleId,
    "Remark":Remark,
    "UserId":UserId
  };
}
class PutCartRemoveItem{
  String CartId;
  bool IsPlaceOrder;
  String UpdateBy;
  PutCartRemoveItem({
   this.CartId,
   this.IsPlaceOrder,
    this.UpdateBy
});
  Map<String,dynamic> toJson()=>{
    "CartId":CartId,
  "IsPlaceOrder":IsPlaceOrder,
  "UpdateBy":UpdateBy
  };
}

String postAddItemToCartJson(PostAddItemToCart data)
{
  final dyn=data.toJson();
  return json.encode(dyn);
}
String postSaleToJson(PostSaleModel data){
  final dyn=data.toJson();
  return json.encode(dyn);
}
String putSaleDelteToJson(PutSaleDeleteModel data){
  final dyn=data.toJson();
  return json.encode(dyn);
}
String putCartRemoveItemToJson(PutCartRemoveItem data){
  final dyn=data.toJson();
  return json.encode(dyn);
}

class EmployeeModel{
  dynamic id;
  String employeeId;
  String createdAt;
  dynamic position;
  String positionName;
  String firstName;
  String lastName;
  String dob;
  String gender;
  String firstNameKh;
  String lastNameKh;
  String email;
  String phoneNumber;
  String marritalStatus;
  String emergencyPhoneNumber;
  String presentAddress;
  String permanetAddress;
  String levelEducation;
  String fieldofEducation;
  String workingStatus;
  String idcardNo;
  dynamic goPId;
  String goPName;
  dynamic totalSale;
  dynamic totalSaleCurrentMonth;
  dynamic totalSaleAmount;
  dynamic totalSaleAmountCurrentMonth;


  EmployeeModel({
    this.id,
    this.employeeId,
    this.createdAt,
    this.position,
    this.positionName,
    this.firstName,
    this.lastName,
    this.dob,
    this.gender,
    this.firstNameKh,
    this.lastNameKh,
    this.email,
    this.phoneNumber,
    this.marritalStatus,
    this.emergencyPhoneNumber,
    this.permanetAddress,
    this.presentAddress,
    this.levelEducation,
    this.fieldofEducation,
    this.workingStatus,
    this.idcardNo,
    this.goPId,
    this.goPName,
    this.totalSale,
    this.totalSaleAmount,
    this.totalSaleCurrentMonth,
    this.totalSaleAmountCurrentMonth

});
  factory EmployeeModel.fromJson(Map<String,dynamic> json)=>EmployeeModel(
    id:json["id"],
    employeeId: json["employeeId"],
    createdAt: json["createdAt"],
    position: json["position"],
    positionName: json["positionName"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    dob: json["dob"],
    gender: json["gender"],
    firstNameKh: json["firstNameKh"],
    lastNameKh: json["lastNameKh"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    marritalStatus: json["marritalStatus"],
    emergencyPhoneNumber: json["emergencyPhoneNumber"],
    permanetAddress: json["permanetAddress"],
    presentAddress: json["presentAddress"],
    levelEducation: json["levelEducation"],
    fieldofEducation: json["fieldofEducation"],
    workingStatus: json["workingStatus"],
    idcardNo: json["idcardNo"],
    goPId: json["goPId"],
    goPName: json["goPName"],
    totalSale: json["totalSale"],
    totalSaleAmount: json["totalSaleAmount"],
    totalSaleCurrentMonth: json["totalSaleCurrentMonth"],
    totalSaleAmountCurrentMonth: json["totalSaleAmountCurrentMonth"]
  );


}
