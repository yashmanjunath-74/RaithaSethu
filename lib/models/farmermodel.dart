import 'package:RaithaSethu/models/product_model.dart';
import 'dart:convert';

class FarmerModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final List<ProductModel>? products;
  final String token;
  final String type = 'farmer'; // Default type for farmer
  final String password;
  final String address;

  FarmerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.token,
    required this.address,
    this.products,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id, // Use '_id' to match API
      'name': name,
      'email': email,
      'address': address,
      'password': password,
      'phone': phone,
      'token': token,
      'products': products?.map((x) => x.toMap()).toList(),
    };
  }

  factory FarmerModel.fromMap(Map<String, dynamic> map) {
    return FarmerModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      token: map['token'] ?? '',
      address: map['address'] ?? '',
      products: map['products'] != null
          ? List<ProductModel>.from(
              map['products'].map((x) => ProductModel.fromMap(x)),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FarmerModel.fromJson(String source) =>
      FarmerModel.fromMap(json.decode(source));
}
