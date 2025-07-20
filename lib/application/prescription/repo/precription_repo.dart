import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farda/app_const/app_urls.dart';
import 'package:farda/application/prescription/model/prescription_model.dart';
import 'package:farda/env.dart';
import 'package:farda/utilities/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrecriptionRepo {
  Future<PrescriptionModel?> getExtractPrescription(File file) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString("access") ?? "";

    final response = await ApiService.postMultipart(
      endpoint: AppUrls.getExtractPrescriptionOcr,
      fileFieldName:
          "image", // This must match your backend's expected field name
      file: file,
      headers: {"Authorization": "Bearer $token"},
    );

    if (response != null) {
      return PrescriptionModel.fromJson(response);
    } else {
      debugPrint("");
      return null;
    }
  }

  Future<dynamic> submitPrescription(PrescriptionModel prescription) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString("access") ?? "";
    
    print( prescription.toSubmit());


    final response = await ApiService.postResponse(
      endpoint: AppUrls.submitPrescription,
      body:  prescription.toSubmit(),
      headers: {"Authorization": "Bearer $token"},
    );

     debugPrint(response.toString());

    if (response != null) {
      return response;
    } else {
      debugPrint(response.toString());
      return null;
    }
  }
}

