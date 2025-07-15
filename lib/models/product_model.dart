import 'dart:convert';

import 'package:amazon_clone/models/rating.dart';

class ProductModel {
  final String productName;
  final double price;
  final double quantity;
  final String description;
  final String category;// New: Type of crop
  final List<String> images;
  final String? id;
  final List<RatingModel>? rating;
  final String farmerId; // New: Farmer who produced the product
  final DateTime? expectedHarvestDate; // New: When crop will be ready

  ProductModel({
    required this.productName,
    required this.price,
    required this.quantity,
    required this.description,
    required this.category,
    required this.images,
    this.id,
    this.rating,
    required this.farmerId,
    this.expectedHarvestDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'description': description,
      'category': category,
      'images': images,
      'id': id,
      'rating': rating?.map((x) => x.toMap()).toList(),
      'farmerId': farmerId,
      'expectedHarvestDate': expectedHarvestDate?.toIso8601String(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productName: map['productName'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      images: List<String>.from(map['images']),
      id: map['_id'] ?? map['id'],
      rating: map['rating'] != null
          ? List<RatingModel>.from(
              map['rating']?.map(
                (x) => RatingModel.fromMap(x),
              ),
            )
          : null,
      farmerId: map['farmerId'] ?? '',
      expectedHarvestDate: map['expectedHarvestDate'] != null
          ? DateTime.parse(map['expectedHarvestDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
