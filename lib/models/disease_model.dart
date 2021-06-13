import 'dart:convert';

class DiseaseModel {
  DateTime? fromDate;
  DateTime? toDate;
  String? disease;

  DiseaseModel({this.fromDate, this.toDate, this.disease});

  Map<String, dynamic> toMap() {
    return {
      "disease": disease,
      "toDate": toDate!.toIso8601String(),
      "fromDate": fromDate!.toIso8601String(),
    };
  }

  factory DiseaseModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return DiseaseModel();
    }
    return DiseaseModel(
      disease: map['disease'],
      toDate: DateTime.parse(map['toDate']),
      fromDate: DateTime.parse(map['fromDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiseaseModel.fromJson(String? source) =>
      DiseaseModel.fromMap(json.decode(source!));
}
