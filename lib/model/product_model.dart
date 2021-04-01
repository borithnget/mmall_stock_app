import 'dart:io';
import 'dart:math';

class Product{
  String id;
  String categoryId;
  String unitid;
  String unitName;
  String productNo;
  String productCode;
  String productImage;
  String createdDate;
  String productName;
  String cartId;
  List<ProductUnit> productUnits;
  ProductDetail productDetail;
  ProductUnit productUnit;
  Product({
    this.id,
    this.categoryId,
    this.unitid,
    this.unitName,
    this.productNo,
    this.productCode,
    this.productImage,
    this.createdDate,
    this.productName,
    this.productUnits,
    this.productDetail,
    this.productUnit,
    this.cartId,
  });
  factory Product.fromJson(Map<String,dynamic> json)=>new Product(
    id: json["id"],
    categoryId: json["categoryId"],
    unitid: json["unitid"],
    productNo: json["productNo"],
    productCode: json["productCode"],
      productImage:json["productImage"],
      createdDate:json["createdDate"],
      productName:json["productName"],
    cartId: json["cartId"],
    productUnits: List<ProductUnit>.from(json["productUnits"].map((x)=>ProductUnit.fromJson(x))),
    productDetail:ProductDetail.fromJson(json["productDetail"]),
    productUnit: ProductUnit.fromJson(json["productUnit"])

  );

  Map<String,dynamic> toJson()=>{
    "id":id,
    "categoryId":categoryId,
    "unitid":unitid,
    "productNo":productNo,
    "productCode":productCode,
    "productImage":productImage,
    "createdDate":createdDate,
    "productName":productName,
    "cartId":cartId,
    "productUnits":List<dynamic>.from(productUnits.map((x)=>toJson()))
  };

}

class ProductSaleModel{
  String id;
  String categoryId;
  String unitid;
  String unitName;
  String productNo;
  String productCode;
  String productImage;
  String createdDate;
  String productName;

  ProductSaleModel({
    this.id,
    this.categoryId,
    this.unitid,
    this.unitName,
    this.productNo,
    this.productCode,
    this.productImage,
    this.createdDate,
    this.productName,

  });
  factory ProductSaleModel.fromJson(Map<String,dynamic> json)=>new ProductSaleModel(
      id: json["id"],
      categoryId: json["categoryId"],
      unitid: json["unitid"],
      productNo: json["productNo"],
      productCode: json["productCode"],
      productImage:json["productImage"],
      createdDate:json["createdDate"],
      productName:json["productName"],

  );
}

class ProductUnit{

  String id;
  String productId;
  String unitTypeId;
  String unitName;
  dynamic cost;
  dynamic price;
  bool typeDefault;
  dynamic orderingNumber;
  dynamic quantity;

  ProductUnit({
    this.id,
    this.productId,
    this.unitTypeId,
    this.unitName,
    this.cost,
    this.price,
    this.typeDefault,
    this.orderingNumber,
    this.quantity
  });

  factory ProductUnit.fromJson(Map<String,dynamic> json)=>new ProductUnit(
    id: json["id"],
    productId: json["productId"],
    unitTypeId: json["unitTypeId"],
    unitName: json["unitName"],
    cost: json["cost"],
    price: json["price"],
    typeDefault: json["typeDefault"],
    orderingNumber: json["orderingNumber"],
    quantity: json["quantity"]
  );

  Map<String,dynamic> toJson()=>{
    "id":id,
    "productId":productId,
    "unitTypeId":unitTypeId,
    "unitName":unitName,
    "cost":cost,
    "price":price,
    "typeDefault":typeDefault,
    "orderingNumber":orderingNumber,
    "quantity":quantity
  };

}

class ProductDetail{
  String productDetailId;
  String productId;
  String productSizeId;
  String productSizeName;
  String productColorId;
  String productColorName;
  String remark;
  bool active;
  ProductDetail({
    this.productDetailId,
    this.productId,
    this.productSizeId,
    this.productSizeName,
    this.productColorId,
    this.productColorName,
    this.remark,
    this.active
  });
  factory ProductDetail.fromJson(Map<String,dynamic> json)=>new ProductDetail(
    productDetailId: json["productDetailId"],
    productId: json["productId"],
    productSizeId: json["productSizeId"],
    productColorName: json["productColorName"],
    productColorId: json["productColorId"],
    productSizeName: json["productSizeName"],
    remark: json["remark"],
    active: json["active"]
  );
  Map<String,dynamic> toJson()=>{
    "productDetailId":productDetailId,
    "productId":productId,
    "productSizeId":productSizeId,
    "productSizeName":productSizeName,
    "productColorId":productColorId,
    "productColorName":productColorName,
    "remark":remark,
    "active":active
  };

}