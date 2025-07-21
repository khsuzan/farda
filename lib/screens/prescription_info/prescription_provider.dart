import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as http;
import 'package:farda/application/prescription/model/prescription_model.dart';
import 'package:farda/application/prescription/repo/precription_repo.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PrescriptionProvider extends ChangeNotifier {
  PrescriptionModel prescriptionModel = PrescriptionModel();
  bool isLoading = false;

  TextEditingController prescriptionNumberController = TextEditingController();
  TextEditingController storeNumberController = TextEditingController();
  TextEditingController pillQtyController = TextEditingController();

  File? file;

  final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery or camera
  Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        file = File(pickedFile.path);
        notifyListeners(); // Update UI with selected image
      }
    } catch (e) {
      debugPrint("Image pick error: $e");
    }
  }

  /// API call to extract prescription from image
  Future<void> getExtractPrescriptionApi() async {
    if (file == null) return;

    try {
      isLoading = true;
      notifyListeners();

      final data = await PrecriptionRepo().getExtractPrescription(file!);
      if (data != null) {
        prescriptionModel = data;
        prescriptionNumberController.text =
            prescriptionModel.pharmacyOrDoctorName.toString();
        storeNumberController.text = prescriptionModel.storeNumber.toString();
        pillQtyController.text =
            prescriptionModel.medicinesNames!.first.qty.toString();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("getExtractPrescription error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //
  Future<bool> submitPrescriptionApi() async {
  try {
    isLoading = true;
    notifyListeners();

    final int response = await PrecriptionRepo().submitPrescription(prescriptionModel);

    if ( response == 201) {
      return true;
    }else{
      return false;
    }

  } catch (e) {
    debugPrint("submitPrescriptionApi error: $e");
    return false;
  } finally {
    isLoading = false;
    notifyListeners();
  }
}


  //get prescription data 
  Future<void> getMyPrescriptionApi()async{
      try{
          final data = await PrecriptionRepo().getPrescription();
          prescriptionModel = data!;
          notifyListeners();
      }catch(e){
        print(e);
      }
  } 
}
