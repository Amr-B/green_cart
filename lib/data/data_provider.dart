import 'dart:convert';
import 'package:green_cart/data/api_endpoints.dart';
import 'package:http/http.dart' as http;
import '../models/new_groceries.dart';

class DataProviders {
  static Future<List<NewGroceriesModel>> fetchNewGroceries() async {
    final response = await http.get(Uri.parse(ApiEndPoints.newGroceries));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      if (jsonList.isEmpty) {
        print('✅ API call succeeded but returned an empty list.');
      } else {
        print('✅ Fetched ${jsonList.length} groceries from API.');
      }

      return jsonList.map((item) => NewGroceriesModel.fromJson(item)).toList();
    } else {
      print('❌ API error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to load groceries');
    }
  }
}
