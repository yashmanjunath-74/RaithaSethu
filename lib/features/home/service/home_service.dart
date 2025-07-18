import 'dart:convert';

import 'package:RaithaSethu/constants/error_handling.dart';
import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/constants/utils.dart';
import 'package:RaithaSethu/models/product_model.dart';
import 'package:RaithaSethu/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeService {
  // Fetch  categary  products
  Future<List<ProductModel>> fetchCategaryProduct(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/product?category=$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
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

  // Fetch deal-of-the-day products

  Future<ProductModel> fetchDealOftheDay(
      {required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    ProductModel product = ProductModel(
      productName: '',
      price: 0,
      quantity: 0,
      description: '',
      category: '',
      images: [],
      farmerId: '', // Provide a default or appropriate value
    );
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/deal_of_day'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            product = ProductModel.fromJson(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
