import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:farda/env.dart';
import 'package:farda/utilities/api_service.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepo {
  Future<Map<String, dynamic>?> sendOtp(String phoneNumber) async {
    try {
      final response = await ApiService.post(
        endpoint: "send-otp/",
        body: {"phone": phoneNumber},
      );

      if (response != null) {
        
      } else {
        debugPrint("OTP request failed.");
      }
      return response;
    } catch (e) {
      debugPrint("sendOtp error: $e");
      return null;
    }
  }


  Future<Map<String, dynamic>?> verifyOtp(String phoneNumber, String otp) async {
    try {
      final response = await ApiService.post(
        endpoint: "verify-otp/",
        body: {"phone": phoneNumber,
        "otp" : otp
        },
      );

      if (response != null) {
        
      } else {
        debugPrint("OTP request failed.");
      }
      return response;
    } catch (e) {
      debugPrint("sendOtp error: $e");
      return null;
    }
  }
  

}