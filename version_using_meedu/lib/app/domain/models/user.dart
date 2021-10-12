class User {
  final int id, active;
  final String name;
  final String? username;
  final String email;
  final String? rol;
  final String? identification;
  final String? type;
  final String? identificationType;
  final String? phone;
  final String? address;
  final String? image;
  final String? state;

  User({
    required this.id,
    required this.active,
    required this.name,
    required this.username,
    required this.email,
    required this.rol,
    required this.identification,
    required this.type,
    required this.identificationType,
    required this.phone,
    required this.address,
    required this.image,
    required this.state,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      active: json['active'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      rol: json['rol'],
      identification: json['identification'],
      type: json['type'],
      identificationType: json['identification_type'],
      phone: json['phone'],
      address: json['address'],
      image: json['image'],
      state: json['state'],  
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['username'] = username;
    _data['email'] = email;
    _data['rol'] = rol;
    _data['identification'] = identification;
    _data['type'] = type;
    _data['identification_type'] = identificationType;
    _data['active'] = active;
    _data['phone'] = phone;
    _data['address'] = address;
    _data['image'] = image;
    _data['state'] = state;
    return _data;
  }
}
