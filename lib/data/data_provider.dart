import 'package:dio/dio.dart';
import 'package:green_cart/core/services/data_service.dart';
import 'package:green_cart/data/api_endpoints.dart';
import 'package:green_cart/data/models/categories/dairy_model.dart';
import 'package:green_cart/data/models/categories/meat_model.dart';
import 'package:green_cart/data/models/categories/vegetables_model.dart';
import 'package:green_cart/data/models/profile/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/categories/fruits_model.dart';
import 'models/categories/new_groceries.dart';

class DataProviders {
  static final DataService _api = DataService();

  static Future<NewGroceriesModel> fetchProductByIdLocally(int id) async {
    final response = await _api.get('${ApiEndPoints.newGroceries}/$id');
    final List<dynamic> jsonList = response.data;
    final List<NewGroceriesModel> all =
        jsonList.map((item) => NewGroceriesModel.fromJson(item)).toList();
    return all.firstWhere((item) => item.id == id);
  }

  static Future<List<NewGroceriesModel>> fetchNewGroceries() async {
    final response = await _api.get(ApiEndPoints.newGroceries);
    final List<dynamic> jsonList = response.data;
    return jsonList.map((item) => NewGroceriesModel.fromJson(item)).toList();
  }

  static Future<VegetablesCatModel> fetchProductById(int id) async {
    final response = await _api.get('${ApiEndPoints.vegetables}/$id');
    return VegetablesCatModel.fromJson(response.data);
  }

  static Future<dynamic> fetchDynamicProductById(
      String category, int id) async {
    final response = await _api.get('${ApiEndPoints.baseUrl}/$category/$id');
    final data = response.data;

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

    throw Exception('Unknown category $category');
  }

  static Future<List<FruitsModel>> fetchFruitsCategory() async {
    final response = await _api.get('${ApiEndPoints.baseUrl}/fruits');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((item) => FruitsModel.fromJson(item)).toList();
  }

  static Future<FruitsModel> fetchFruitById(int id) async {
    final response = await _api.get('${ApiEndPoints.baseUrl}/fruits/$id');
    return FruitsModel.fromJson(response.data);
  }

  static Future<List<DairyModel>> fetchDairyCategory() async {
    final response = await _api.get('${ApiEndPoints.baseUrl}/dairy');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((item) => DairyModel.fromJson(item)).toList();
  }

  static Future<List<MeatModel>> fetchMeatCategory() async {
    final response = await _api.get('${ApiEndPoints.baseUrl}/meat');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((item) => MeatModel.fromJson(item)).toList();
  }

  static Future<List<ProfileModel>> fetchProfiles() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final dio = Dio();
    final response = await dio.get(
      '${ApiEndPoints.baseUrl}/profiles',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    final List<dynamic> jsonList = response.data;
    return jsonList.map((item) => ProfileModel.fromJson(item)).toList();
  }

  static Future<List<VegetablesCatModel>> fetchVegetablesCategory() async {
    final response = await _api.get(ApiEndPoints.vegetables);
    final List<dynamic> jsonList = response.data;
    return jsonList.map((item) => VegetablesCatModel.fromJson(item)).toList();
  }

  static Future<void> createPaypalPayment() async {
    final response = await _api.post(
      '${ApiEndPoints.baseUrl}/create-paypal-order',
      data: {"amount": "20.00"},
    );

    final approvalLink = response.data['links']
        .firstWhere((link) => link['rel'] == 'approve')['href'];
    print('Open this URL for approval: $approvalLink');
  }
}
