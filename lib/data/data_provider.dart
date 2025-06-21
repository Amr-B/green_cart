// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:green_cart/data/api_endpoints.dart';
import 'package:green_cart/models/categories/vegetables_model.dart';
import 'package:http/http.dart' as http;
import '../models/new_groceries.dart';

class DataProviders {
  static Future<NewGroceriesModel> fetchProductByIdLocally(int id) async {
    final response =
        await http.get(Uri.parse('${ApiEndPoints.newGroceries}/$id'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      final List<NewGroceriesModel> all =
          jsonList.map((item) => NewGroceriesModel.fromJson(item)).toList();

      return all.firstWhere((item) => item.id == id);
    } else {
      throw Exception('Failed to fetch groceries');
    }
  }

  static Future<List<NewGroceriesModel>> fetchNewGroceries() async {
    final response = await http.get(Uri.parse(ApiEndPoints.newGroceries));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((item) => NewGroceriesModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch groceries');
    }
  }

  static Future<VegetablesCatModel> fetchProductById(int id) async {
    final response =
        await http.get(Uri.parse('${ApiEndPoints.vegetables}/$id'));
    if (response.statusCode == 200) {
      return VegetablesCatModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }

  // > fetch data for details screen dynamicly
  static Future<dynamic> fetchDynamicProductById(
      String category, int id) async {
    final url = Uri.parse('${ApiEndPoints.baseUrl}/$category/$id');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (category == 'groceries') {
        final product = NewGroceriesModel.fromJson(data);
        return product;
      } else if (category == 'vegetables') {
        final product = VegetablesCatModel.fromJson(data);
        return product;
      } else {}
    } else {}

    throw Exception('Failed to load product from $category');
  }

  // > define
  static Future<List<VegetablesCatModel>> fetchVegetablesCategory() async {
    final response = await http.get(Uri.parse(ApiEndPoints.vegetables));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      if (jsonList.isEmpty) {
        print('✅ API call succeeded but returned an empty list.');
      } else {
        print('✅ Fetched ${jsonList.length} vegetables from API.');
      }
      return jsonList.map((item) => VegetablesCatModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch vegetables');
    }
  }
}
