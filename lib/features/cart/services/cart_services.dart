import 'dart:convert';

import 'package:RaithaSethu/constants/error_handling.dart';
import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/constants/utils.dart';
import 'package:RaithaSethu/models/product_model.dart';
import 'package:RaithaSethu/models/usermodel.dart';
import 'package:RaithaSethu/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartServices {
  void DeleteFormCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/delete-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }
}
