import 'dart:convert';

class InventoryResponse {
  int itemsCount;
  List<Inventory> model;
  dynamic pageSize;
  dynamic pageNumber;
  dynamic pageCount;

  InventoryResponse(
      {this.itemsCount,
      this.model,
      this.pageSize,
      this.pageCount,
      this.pageNumber});

  factory InventoryResponse.fromJson(Map<String, dynamic> json) =>
      InventoryResponse(
          itemsCount: json["itemsCount"],
          model: List<Inventory>.from(
              json["model"].map((x) => Inventory.fromJson(x))),
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

class Inventory {
  String inventory_id;
  String inventory_date;
  String inventory_status_id;
  String product_id;
  dynamic total_quantity;
  dynamic in_quantity;
  dynamic out_quantity;
  String ref_id;
  String remark;
  String unit;
  String warehouse_id;
  String product_size_id;
  String product_size_name;
  String product_color_id;
  String product_color_name;
  String product_code;
  String product_name;
  String product_default_unit_name;
  String product_detail_id;
  String product_image;
  dynamic size_ordering_number;

  Inventory(
      {this.inventory_id,
      this.inventory_date,
      this.inventory_status_id,
      this.product_id,
      this.total_quantity,
      this.in_quantity,
      this.out_quantity,
      this.ref_id,
      this.remark,
      this.unit,
      this.warehouse_id,
      this.product_size_id,
      this.product_size_name,
      this.product_color_id,
      this.product_color_name,
      this.product_code,
      this.product_name,
      this.product_default_unit_name,
      this.product_detail_id,
      this.product_image,
      this.size_ordering_number});

  factory Inventory.fromJson(Map<String, dynamic> json) => new Inventory(
      inventory_id: json["inventory_id"],
      inventory_date: json["inventory_date"],
      inventory_status_id: json["inventory_status_id"],
      product_id: json["product_id"],
      total_quantity: json["total_quantity"],
      in_quantity: json["in_quantity"],
      out_quantity: json["out_quantity"],
      ref_id: json["ref_id"],
      remark: json["remark"],
      unit: json["unit"],
      warehouse_id: json["warehouse_id"],
      product_size_id: json["product_size_id"],
      product_size_name: json["product_size_name"],
      product_color_id: json["product_color_id"],
      product_color_name: json["product_color_name"],
      product_code: json["product_code"],
      product_default_unit_name: json["product_default_unit_name"],
      product_name: json["product_name"],
      product_detail_id: json["product_detail_id"],
      product_image: json["product_image"],
      size_ordering_number: json["size_ordering_number"]);

  Map<String, dynamic> toJson() => {
        "inventory_id": inventory_id,
        "inventory_date": inventory_date,
        "inventory_status_id": inventory_status_id,
        "product_id": product_id,
        "total_quantity": total_quantity,
        "in_quantity": in_quantity,
        "out_quantity": out_quantity,
        "ref_id": ref_id,
        "remark": remark,
        "unit": unit,
        "warehouse_id": warehouse_id,
        "product_size_id": product_size_id,
        "product_size_name": product_size_name,
        "product_color_id": product_color_id,
        "product_color_name": product_color_name,
        "product_code": product_code,
        "product_default_unit_name": product_default_unit_name,
        "product_name": product_name,
        "product_detail_id": product_detail_id,
        "product_image": product_image,
        "size_ordering_number": size_ordering_number
      };
}

InventoryResponse inventoryFromJson(String str) {
  final jsonData = json.decode(str);
  return InventoryResponse.fromJson(jsonData);
}
