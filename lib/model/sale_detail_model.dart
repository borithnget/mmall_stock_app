
import 'package:markarian_sales/model/product_model.dart';

class SDCustomer{
  String id;
  String customerNo;
  String noted;
  //List<SDCustomerContactPhone> tbContactPhone;
  SDCustomer({
   this.id,
   this.customerNo,
   this.noted
});
  factory SDCustomer.fromJson(Map<String,dynamic> json)=>new SDCustomer(
    id: json["id"],
    customerNo: json["customerNo"],
    noted: json["noted"],
  );

}

class SDCustomerContactPhone{

}
class SDDelivery{
  String sale_delivery_id;
  String sale_id;
  String delivery_id;
  String delivery_name;
  String delivery_status;
  String delivery_date;
  String contact_person_name;
  String contact_person_phone;
  SDDelivery({
   this.sale_delivery_id,
   this.sale_id,
   this.delivery_id,
   this.delivery_name,
   this.delivery_status,
    this.delivery_date,
    this.contact_person_name,
    this.contact_person_phone
});
  factory SDDelivery.fromJson(Map<String,dynamic> json)=>new SDDelivery(
    sale_delivery_id: json["sale_delivery_id"],
    sale_id: json["sale_id"],
    delivery_id: json["delivery_id"],
    delivery_name: json["delivery_name"],
    delivery_status: json["delivery_status"],
    delivery_date: json["delivery_date"],
    contact_person_name: json["contact_person_name"],
    contact_person_phone: json["contact_person_phone"],
  );
}

class SaleDetail{
  String id;
  String saleId;
  String productId;
  dynamic quantity;
  dynamic price;
  String unitTypeId;
  dynamic actualPrice;
  dynamic discountAmount;
  String productSizeId;
  String productColorId;
  String productStatus;
  dynamic total;
  String unitId;
  String productColorName;
  String productSizeName;
  ProductSaleModel product;
  SaleDetail({
   this.id,
   this.saleId,
    this.productId,
    this.quantity,
    this.price,
    this.unitTypeId,
    this.actualPrice,
    this.discountAmount,
    this.productSizeId,
    this.productColorId,
    this.productStatus,
    this.total,
    this.unitId,
    this.productSizeName,
    this.productColorName,
    this.product
});
  factory SaleDetail.fromJson(Map<String,dynamic> json)=>new SaleDetail(
    id: json["id"],
    saleId: json["saleId"],
    productId: json["productId"],
    quantity: json["quantity"],
    price: json["price"],
    unitTypeId: json["unitTypeId"],
    actualPrice: json["actualPrice"],
    discountAmount: json["discountAmount"],
    productColorId: json["productColorId"],
    productSizeId: json["productSizeId"],
    productStatus: json["productStatus"],
    total: json["total"],
    unitId: json["unitId"],
    productSizeName: json["productSizeName"],
    productColorName: json["productColorName"],
    product: ProductSaleModel.fromJson(json["product"]),

  );
}

class CustomerContactPhoneModel{
  String customerContactId;
  String phoneNumber;
  CustomerContactPhoneModel({
   this.customerContactId,
   this.phoneNumber
});
  factory CustomerContactPhoneModel.fromJson(Map<String,dynamic> json)=>new CustomerContactPhoneModel(
    customerContactId: json["customerContactId"],
    phoneNumber: json["phoneNumber"]
  );
}
class SaleWorkflowModel{
  String sale_wf_id;
  String sale_id;
  String sale_status;
  String show_sale_status;
  String created_by;
  String created_date;
  String remark;
  SaleWorkflowModel({
   this.sale_wf_id,
   this.sale_id,
   this.sale_status,
   this.show_sale_status,
   this.created_by,
   this.created_date,
   this.remark
});
  factory SaleWorkflowModel.fromJson(Map<String,dynamic> json)=>new SaleWorkflowModel(
    sale_id: json["sale_id"],
    sale_wf_id: json["sale_wf_id"],
    sale_status: json["sale_status"],
    show_sale_status: json["show_sale_status"],
    created_by: json["created_by"],
    created_date: json["created_date"],
    remark: json["remark"]
  );
}
