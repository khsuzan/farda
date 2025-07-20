class PrescriptionModel {
  String? pharmacyOrDoctorName;
  String? contactDetails;
  String? dateFilled;
  String? dateExpired;
  String? address;
  String? rxNumber;
  String? storeNumber;
  List<MedicinesNames>? medicinesNames;

  PrescriptionModel(
      {this.pharmacyOrDoctorName,
      this.contactDetails,
      this.dateFilled,
      this.dateExpired,
      this.address,
      this.rxNumber,
      this.storeNumber,
      this.medicinesNames});

  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    pharmacyOrDoctorName = json['pharmacy_or_doctor_name'];
    contactDetails = json['contact_details'];
    dateFilled = json['date_filled'];
    dateExpired = json['date_expired'];
    address = json['address'];
    rxNumber = json['rx_number'];
    storeNumber = json['store_number'];
    if (json['medicines_names'] != null) {
      medicinesNames = <MedicinesNames>[];
      json['medicines_names'].forEach((v) {
        medicinesNames!.add(new MedicinesNames.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pharmacy_or_doctor_name'] = this.pharmacyOrDoctorName;
    data['contact_details'] = this.contactDetails;
    data['date_filled'] = this.dateFilled;
    data['date_expired'] = this.dateExpired;
    data['address'] = this.address;
    data['rx_number'] = this.rxNumber;
    data['store_number'] = this.storeNumber;
    if (this.medicinesNames != null) {
      data['medicines_names'] =
          this.medicinesNames!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  Map<String, dynamic> toSubmit() => {
  "pharmacy_or_doctor_name": pharmacyOrDoctorName,
  "contact_details": contactDetails,
  "date_filled": dateFilled,
  "date_expired": dateExpired,
  "address": address,
  "rx_number": rxNumber,
  "store_number": storeNumber,
  "medicines_names": medicinesNames!.map((m) => m.toMedicineName()).toList(),
};
}

class MedicinesNames {
  String? medicineName;
  String? genericName;
  String? instructions;
  String? qty;
  String? refillsInfo;
  String? sideEffects;

  MedicinesNames(
      {this.medicineName,
      this.genericName,
      this.instructions,
      this.qty,
      this.refillsInfo,
      this.sideEffects});

  MedicinesNames.fromJson(Map<String, dynamic> json) {
    medicineName = json['medicine_name'];
    genericName = json['generic_name'];
    instructions = json['instructions'];
    qty = json['qty'];
    refillsInfo = json['refills_info'];
    sideEffects = json['side_effects'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicine_name'] = this.medicineName;
    data['generic_name'] = this.genericName;
    data['instructions'] = this.instructions;
    data['qty'] = this.qty;
    data['refills_info'] = this.refillsInfo;
    data['side_effects'] = this.sideEffects;
    return data;
  }

  Map<String, dynamic> toMedicineName() => {
  "medicine_name": medicineName,
  "generic_name": genericName,
  "instructions": instructions,
  "qty": qty,
  "refills_info" : refillsInfo,
  "side_effects": sideEffects,
  
};

}
