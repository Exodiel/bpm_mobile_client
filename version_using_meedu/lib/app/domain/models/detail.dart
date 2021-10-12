import 'package:google_maps/app/domain/models/product.dart';

class Detail {
  int? id;
  late String price;
  late String discount;
  late String discountvalue;
  late String subtotal;
  late int quantity;
  Product? product;

  Detail({
    this.id,
    required this.price,
    required this.discount,
    required this.discountvalue,
    required this.subtotal,
    required this.quantity,
    this.product,
  });
  
  Detail.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    price = json["price"].toString();
    discount = json["discount"].toString();
    discountvalue = json["discountvalue"].toString();
    subtotal = json["subtotal"].toString();
    quantity = json["quantity"].toInt();
    product =
        (json["product"] != null) ? Product.fromJson(json["product"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["price"] = price;
    data["discount"] = discount;
    data["discountvalue"] = discountvalue;
    data["subtotal"] = subtotal;
    data["quantity"] = quantity;
    if (product != null) {
      data["product"] = product!.toJson();
    }
    return data;
  }
}
