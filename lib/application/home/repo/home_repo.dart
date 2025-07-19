

import 'package:dio/dio.dart';
import 'package:farda/app_const/app_urls.dart';
import 'package:farda/utilities/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepo {
  
Future<dynamic> getDoseTime() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  try {
    final  response = await ApiService.getList(
      headers: {
        "Authorization": "Bearer ${preferences.getString("access") ?? ""}",
      },
      endpoint: AppUrls.getDoseTime,
    );

    if (response != null) {
      return response;
    } else {
      debugPrint("Failed to fetch dose time.");
      return null;
    }
  } catch (e) {
    debugPrint("getDoseTime error: $e");
    return null;
  }
}

}