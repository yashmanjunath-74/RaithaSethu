import 'dart:convert';
import 'package:amazon_clone/features/admin/screen/admin_screen.dart';
import 'package:amazon_clone/models/farmermodel.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:amazon_clone/providers/farmer_provider.dart';

class FarmerAuthService {
  // Sign up farmer
  void signUpFarmer({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
  }) async {
    try {
      FarmerModel farmer = FarmerModel(
        id: '',
        name: name,
        email: email,
        password: password,
        phone: phone,
        token: '',
        products: [],
        address: address,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/farmer/signup'),
        body: farmer.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, 'Farmer account created successfully. Please login.');
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  // Sign in farmer
  void signInFarmer({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/farmer/login'),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("Raw API Response: ${res.body}");

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString(
              'x-farmer-auth-token', jsonDecode(res.body)['token']);
          print("Token saved: ${jsonDecode(res.body)['token']}");
          FarmerAuthService().getFarmer(context);
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  // Get farmer details
  void getFarmer(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-farmer-auth-token');
      if (token == null) {
        print("No token found, skipping getFarmer.");
        return;
      }
      print("Token retrieved: $token");
      var tokenRes = await http.post(
        Uri.parse('$uri/api/farmer/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-farmer-auth-token': token
        },
      );
      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response farmerRes = await http.get(
          Uri.parse('$uri/farmer'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-farmer-auth-token': token
          },
        );
        print("Farmer API Response: ${farmerRes.body}");
        var farmerProvider =
            Provider.of<FarmerProvider>(context, listen: false);
        farmerProvider.setFarmer(farmerRes.body);
        print("Farmer data set in provider: ${farmerProvider.farmer.token}");

        
        Navigator.pushNamedAndRemoveUntil(
            context, AdminScreen.routeName, (route) => false);
      }
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }
}
