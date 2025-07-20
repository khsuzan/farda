import 'dart:convert';

import 'package:farda/application/home/model/dose_time_model.dart';
import 'package:farda/application/home/repo/home_repo.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  List<DoseTimeModel> doseTimeModel = [];

  Future<void> getDoseTimeApi() async {
    try {
      final response = await HomeRepo().getDoseTime();

      if (response != null && response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          doseTimeModel =
              data.map((item) => DoseTimeModel.fromJson(item)).toList();
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("getDoseTimeApi error: $e");
    }
  }
}
