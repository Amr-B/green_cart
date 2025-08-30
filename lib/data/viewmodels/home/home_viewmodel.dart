import 'package:flutter/material.dart';
import 'package:green_cart/data/data_provider.dart';
import 'package:green_cart/data/models/categories/new_groceries.dart';

class HomeViewModel extends ChangeNotifier {
  List<NewGroceriesModel> _newGroceries = [];

  List<NewGroceriesModel> get groceries => _newGroceries;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchGroceries() async {
    _isLoading = true;

    _error = null;
    notifyListeners();

    try {
      _newGroceries = await DataProviders.fetchNewGroceries();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
