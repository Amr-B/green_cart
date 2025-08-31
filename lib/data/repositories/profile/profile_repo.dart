import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_endpoints.dart';
import '../../models/profile/profile_model.dart';

class ProfileRepository {
  final Dio _api = Dio();

  Future<ProfileModel> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await _api.get(
      '${ApiEndPoints.baseUrl}/profile',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    return ProfileModel.fromJson(response.data);
  }
}
