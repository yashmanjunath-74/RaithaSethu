import 'package:amazon_clone/models/farmermodel.dart';
import 'package:flutter/material.dart';

class FarmerProvider extends ChangeNotifier {
  FarmerModel _farmer = FarmerModel(
    id: '',
    name: '',
    email: '',
    phone: '',
    products: [],
    address: '',
    password: '',
    token: '',
  );

  FarmerModel get farmer => _farmer;

  void setFarmer(String farmer) {
    _farmer = FarmerModel.fromJson(farmer);
    notifyListeners();
  }

  void setFarmerModel(FarmerModel farmer) {
    _farmer = farmer;
    notifyListeners();
  }

  void setFarmerFromModel(FarmerModel farmer) {
    _farmer = farmer;
    notifyListeners();
  }
}
