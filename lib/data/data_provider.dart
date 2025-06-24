// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:green_cart/data/api_endpoints.dart';
import 'package:green_cart/data/models/categories/dairy_model.dart';
import 'package:green_cart/data/models/categories/meat_model.dart';
import 'package:green_cart/data/models/categories/vegetables_model.dart';
import 'package:green_cart/data/models/profile/profile_model.dart';
import 'package:http/http.dart' as http;
import 'models/categories/fruits_model.dart';
import 'models/categories/new_groceries.dart';

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
        return NewGroceriesModel.fromJson(data);
      } else if (category == 'vegetables') {
        return VegetablesCatModel.fromJson(data);
      } else if (category == 'fruits') {
        return FruitsModel.fromJson(data);
      } else if (category == 'dairy') {
        return DairyModel.fromJson(data);
      } else if (category == 'meat') {
        return MeatModel.fromJson(data);
      }
    }

    throw Exception('Failed to load product from $category');
  }

  // > fruits
  static Future<List<FruitsModel>> fetchFruitsCategory() async {
    final response =
        await http.get(Uri.parse('${ApiEndPoints.baseUrl}/fruits'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((item) => FruitsModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch fruits');
    }
  }

  // ✅ Get one fruit by ID
  static Future<FruitsModel> fetchFruitById(int id) async {
    final response =
        await http.get(Uri.parse('${ApiEndPoints.baseUrl}/fruits/$id'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return FruitsModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch fruit');
    }
  }

  // > get dairy
  static Future<List<DairyModel>> fetchDairyCategory() async {
    final response = await http.get(Uri.parse('${ApiEndPoints.baseUrl}/dairy'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      if (jsonList.isEmpty) {
      } else {}

      return jsonList.map((item) => DairyModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch dairy products');
    }
  }

  // > get meat
  static Future<List<MeatModel>> fetchMeatCategory() async {
    final response = await http.get(Uri.parse('${ApiEndPoints.baseUrl}/meat'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      return jsonList.map((item) => MeatModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch meat category');
    }
  }

  // > user profile method
  static Future<List<ProfileModel>> fetchProfiles() async {
    final response =
        await http.get(Uri.parse('${ApiEndPoints.baseUrl}/profile'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((item) => ProfileModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch profiles');
    }
  }

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

  static Future<void> createPaypalPayment() async {
    final response = await http.post(
      Uri.parse('${ApiEndPoints.baseUrl}/create-paypal-order'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"amount": "20.00"}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final approvalLink =
          data['links'].firstWhere((link) => link['rel'] == 'approve')['href'];

      print('Open this URL for approval: $approvalLink');
    } else {
      print('Error: ${response.statusCode}');
      print('Body: ${response.body}');
    }
  }
}
