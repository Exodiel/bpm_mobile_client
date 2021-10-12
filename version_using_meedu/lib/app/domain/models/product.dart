import 'package:google_maps/app/domain/models/category.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.price,
    required this.stock,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });
  late final int id;
  late final String name;
  late final String description;
  late final String cost;
  late final String price;
  late final int stock;
  int quantity = 1;
  double subtotal = 0;
  late final String image;
  late final String createdAt;
  late final String updatedAt;
  late final Category? category;
  
  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    cost = json['cost'];
    price = json['price'];
    stock = json['stock'];
    quantity = 1;
    subtotal = quantity * double.parse(json['price']);
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['category'] != null) {
      category = Category.fromJson(json['category']);
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['cost'] = cost;
    _data['price'] = price;
    _data['stock'] = stock;
    _data['image'] = image;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    if (category != null) {
      _data['category'] = category!.toJson();
    }
    return _data;
  }
}
