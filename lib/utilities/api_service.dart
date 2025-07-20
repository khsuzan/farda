import 'dart:convert';
import 'dart:io';
import 'package:farda/env.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Get headers with optional Bearer token
  static Future<Map<String, String>> _buildHeaders({Map<String, String>? customHeaders, bool auth = false}) async {
    final headers = <String, String>{
      "Content-Type": "application/json",
      ...?customHeaders,
    };

    if (auth) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access'); // or whatever key you use
      if (token != null && token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token";
      }
    }

    return headers;
  }

  // POST request
  static Future<Map<String, dynamic>?> post({
    required String endpoint,
    required dynamic body,
    Map<String, String>? headers,
    bool auth = false,
  }) async {
    try {
      final finalHeaders = await _buildHeaders(customHeaders: headers, auth: auth);
      final response = await http.post(
        Uri.parse("$appBaseUrl/$endpoint"),
        headers: finalHeaders,
        body: jsonEncode(body),
      );

      debugPrint("POST $endpoint => ${response.statusCode}: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        debugPrint("Error ${response.statusCode}: ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("POST request error: $e");
      return null;
    }
  }

  //post with get reponse
  static Future<http.Response?> postResponse({
  required String endpoint,
  required dynamic body,
  Map<String, String>? headers,
  bool auth = false,
}) async {
  try {
    final finalHeaders = await _buildHeaders(customHeaders: headers, auth: auth);
    final response = await http.post(
      Uri.parse("$appBaseUrl/$endpoint"),
      headers: finalHeaders,
      body: jsonEncode(body),
    );

    debugPrint("POST $endpoint => ${response.statusCode}: ${response.body}");

    return response; // ← Return full response no matter what

  } catch (e) {
    debugPrint("POST request error: $e");
    return null;
  }
}


  // GET request
  static Future<Map<String, dynamic>?> get({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    bool auth = false,
  }) async {
    try {
      final uri = Uri.parse("$appBaseUrl/$endpoint").replace(queryParameters: queryParams);
      final finalHeaders = await _buildHeaders(customHeaders: headers, auth: auth);
      final response = await http.get(
        uri,
        headers: finalHeaders,
      );

      debugPrint("GET $endpoint => ${response.statusCode}: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint("Error ${response.statusCode}: ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("GET request error: $e");
      return null;
    }
  }

   static Future<http.Response?> getList({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse("$appBaseUrl/$endpoint").replace(queryParameters: queryParams);
      final response = await http.get(
        uri,
        headers: headers ?? {"Content-Type": "application/json"},
      );

      debugPrint("GET $endpoint => ${response.statusCode}: ${response.body}");
      return response;
    } catch (e) {
      debugPrint("GET request error: $e");
      return null;
    }
  }

   static Future<Map<String, dynamic>?> postMultipart({
    required String endpoint,
    required String fileFieldName,
    required File file,
    Map<String, String>? headers,
    Map<String, String>? fields,
  }) async {
    try {
      final uri = Uri.parse("$appBaseUrl/$endpoint");
      var request = http.MultipartRequest("POST", uri);

      // Headers
      request.headers.addAll(headers ?? {"Content-Type": "multipart/form-data"});

      // Add file
      request.files.add(await http.MultipartFile.fromPath(fileFieldName, file.path));

      // Add other fields (if any)
      if (fields != null) {
        request.fields.addAll(fields);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint("Multipart POST $endpoint => ${response.statusCode}: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Multipart POST error: $e");
      return null;
    }
  }
}
