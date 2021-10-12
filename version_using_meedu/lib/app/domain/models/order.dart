import 'package:google_maps/app/domain/models/user.dart';

class Order {
  Order({
    required this.id,
    required this.sequential,
    required this.date,
    this.discount,
    required this.subtotal,
    required this.tax,
    required this.total,
    required this.description,
    required this.type,
    required this.payment,
    required this.state,
    required this.address,
    required this.origin,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.person,
  });
  late final int id;
  late final String sequential;
  late final String date;
  late final String? discount;
  late final double subtotal;
  late final double tax;
  late final double total;
  late final String description;
  late final String type;
  late final String payment;
  late final String state;
  late final String address;
  late final String origin;
  late final String createdAt;
  late final String updatedAt;
  late final User? user;
  late final User? person;
  
  Order.fromJson(Map<String, dynamic> json){
    id = json['id'];
    sequential = json['sequential'];
    date = json['date'];
    discount = json['discount'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    total = json['total'];
    description = json['description'];
    type = json['type'];
    payment = json['payment'];
    state = json['state'];
    address = json['address'];
    origin = json['origin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = (json["user"] != null) ? User.fromJson(json['user']) : null;
    person = (json["user"] != null) ? User.fromJson(json['person']): null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sequential'] = sequential;
    _data['date'] = date;
    _data['discount'] = discount;
    _data['subtotal'] = subtotal;
    _data['tax'] = tax;
    _data['total'] = total;
    _data['description'] = description;
    _data['type'] = type;
    _data['payment'] = payment;
    _data['state'] = state;
    _data['address'] = address;
    _data['origin'] = origin;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    if (user != null) {
      _data['user'] = user!.toJson();
    }
    if (person != null) {
      _data['person'] = person!.toJson();
    }
    return _data;
  }
}

class Orders {

  late final int id;
  late final String sequential;
  late final String date;
  late final String discount;
  late final String subtotal;
  late final String tax;
  late final String total;
  late final String description;
  late final String type;
  late final String payment;
  late final String state;
  late final String address;
  late final String origin;
  late final String createdAt;
  late final String updatedAt;
  late final User? user;
  late final User? person;

  Orders({
    required this.id,
    required this.sequential,
    required this.date,
    required this.discount,
    required this.subtotal,
    required this.tax,
    required this.total,
    required this.description,
    required this.type,
    required this.payment,
    required this.state,
    required this.address,
    required this.origin,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.person,
  });
  Orders.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    sequential = json["sequential"];
    date = json["date"];
    discount = json["discount"];
    subtotal = json["subtotal"];
    tax = json["tax"];
    total = json["total"];
    description = json["description"];
    type = json["type"];
    payment = json["payment"];
    state = json["state"];
    address = json["address"];
    origin = json["origin"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    user = (json["user"] != null) ? User.fromJson(json['user']) : null;
    person = (json["user"] != null) ? User.fromJson(json['person']): null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["sequential"] = sequential;
    data["date"] = date;
    data["discount"] = discount;
    data["subtotal"] = subtotal;
    data["tax"] = tax;
    data["total"] = total;
    data["description"] = description;
    data["type"] = type;
    data["payment"] = payment;
    data["state"] = state;
    data["address"] = address;
    data["origin"] = origin;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (person != null) {
      data['person'] = person!.toJson();
    }
    return data;
  }
}