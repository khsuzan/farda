import 'package:farda/application/authentication/repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Make sure you import your repo

class LoginProvider extends ChangeNotifier {
  String access = "";
  String refresh = "";
  String id = "";

  // Send OTP
  Future<bool> sendOtpApi() async {
    final response = await AuthenticationRepo().sendOtp("+8801726930828");

    if (response != null && response["otp"] != null) {
      return true;
    } else {
      return false;
    }
  }

  // Verify OTP and store tokens
  Future<bool> verifyOtpApi(String otp) async {
    final response = await AuthenticationRepo().verifyOtp("+8801726930828", otp);

    if (response != null && response["access"] != null) {
      access = response["access"];
      refresh = response["refresh"];
      id = response["id"].toString();

      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access', access);
      await prefs.setString('refresh', refresh);
      await prefs.setString('id', id);

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  // Load data from SharedPreferences (e.g., on app startup)
  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    access = prefs.getString('access') ?? '';
    refresh = prefs.getString('refresh') ?? '';
    id = prefs.getString('id') ?? '';
    notifyListeners();
  }

  // Optional: Clear data
  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    access = "";
    refresh = "";
    id = "";
    notifyListeners();
  }
}
