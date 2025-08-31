import 'package:flutter/foundation.dart';
import 'package:green_cart/data/models/profile/profile_model.dart';
import 'package:green_cart/data/repositories/profile/profile_repo.dart';

class ProfileViewmodel extends ChangeNotifier {
  final ProfileRepository _repo = ProfileRepository();

  ProfileModel? _profile;
  bool _loading = false;
  String? _error;

  ProfileModel? get profile => _profile;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> getProfile() async {
    _loading = true;
    notifyListeners();

    try {
      _profile = await _repo.fetchProfile();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;
    notifyListeners();
  }
}
