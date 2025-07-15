import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/providers/farmer_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class FarmerServices {
  // sell Product service
  void sellProduct({
    required BuildContext context,
    required String productName,
    required double price,
    required double quantity,
    required String description,
    required String category,
    required List<File> images,
    required DateTime expectedHarvestDate, // Add this
  }) async {
    final farmerProvider = Provider.of<FarmerProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('dtroxur2z', 'nniuhyjr');
      List<String> imageUrl = [];

      for (int i = 0; i < images.length; i++) {
        try {
          final CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(images[i].path, folder: productName),
          );

          print("Uploaded Image URL: ${res.secureUrl}"); // Debugging
          imageUrl.add(res.secureUrl);
        } catch (e) {
          if (e is DioException) {
            print("Cloudinary Upload Error: ${e.response?.data}");
          } else {
            print("Cloudinary Upload Error: ${e.toString()}");
          }
          showSnackBar(context, "Image upload failed: ${e.toString()}");
          return; // Stop execution if upload fails
        }
      }
      print("Payload: $imageUrl");

      print('Token: ${farmerProvider.farmer.id}');

      ProductModel product = ProductModel(
        productName: productName,
        price: price,
        quantity: quantity,
        description: description,
        category: category,
        images: imageUrl,
        farmerId: farmerProvider.farmer.id,
        expectedHarvestDate: expectedHarvestDate, // Pass date
      );
      print("Payload: ${product.toJson()}");
      print('Token: ${farmerProvider.farmer.id}');

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-farmer-auth-token': farmerProvider.farmer.token,
        },
        body: product.toJson(),
      );
      print('Token: ${farmerProvider.farmer.token}');

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Product Added Successfully");
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get all Product
  Future<List<ProductModel>> fetchAllproduct(BuildContext context) async {
    final farmerProvider = Provider.of<FarmerProvider>(context, listen: false);
    var farmerId = farmerProvider.farmer.id; // Use camelCase
    List<ProductModel> productList = [];
    try {
      print('Token: ${farmerProvider.farmer.token}');
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-product?farmerId=$farmerId'), // <-- fix here
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-farmer-auth-token': farmerProvider.farmer.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                ProductModel.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required ProductModel Product,
    required VoidCallback Onsuccess,
  }) async {
    final farmerprovider = Provider.of<FarmerProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-farmer-auth-token': farmerprovider.farmer.token,
        },
        body: jsonEncode({
          'id': Product.id,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            Onsuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Fetch all orders for a specific farmer
  Future<List<Order>> fetchOrdersByFarmer(BuildContext context) async {
    final farmerProvider = Provider.of<FarmerProvider>(context, listen: false);
    final farmerId = farmerProvider.farmer.id; // Use camelCase
    print('Farmer ID used for orders: $farmerId');
    print('Farmer Token: ${farmerProvider.farmer.token}');
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-orders-by-farmer?farmerId=$farmerId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-farmer-auth-token': farmerProvider.farmer.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void chnageOrderState({
    required BuildContext context,
    required int Status,
    required Order order,
    required VoidCallback Onsuccess,
  }) async {
    final farmerProvider = Provider.of<FarmerProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': farmerProvider.farmer.token,
        },
        body: jsonEncode({'id': order.id, 'Status': Status}),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            Onsuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

// Get earnings and sales data
  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final farmerProvider = Provider.of<FarmerProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarnings = 0;
    var farmerId = farmerProvider.farmer.id; // Use camelCase

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/analytics?farmerId=$farmerId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-farmer-auth-token': farmerProvider.farmer.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            var response = jsonDecode(res.body);
            totalEarnings = response['totalEarnings'];
            sales = [
              Sales('Mobiles', response['MobilesEarnings']),
              Sales('Essentials', response['EssentialsEarnings']),
              Sales('Appliances', response['AppliancesEarnings']),
              Sales('Books', response['BookEarnings']),
              Sales('Fashion', response['FashionEarnings']),
            ];
          });
    } catch (e) {
      print(e.toString);
      showSnackBar(context, e.toString());
    }
    return {'sales': sales, 'totalEarnings': totalEarnings};
  }
}
