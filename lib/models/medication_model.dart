import 'dart:convert';

class MedicationModel {
  String? medicineName;
  String? reason;

  MedicationModel({this.reason, this.medicineName});

  Map<String, dynamic> toMap() {
    return {
      "medicineName": medicineName,
      "reason": reason,
    };
  }

  factory MedicationModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return MedicationModel();
    }
    return MedicationModel(
      medicineName: map['medicineName'],
      reason: map['reason'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicationModel.fromJson(String? source) =>
      MedicationModel.fromMap(json.decode(source!));
}
