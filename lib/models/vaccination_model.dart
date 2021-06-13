import 'dart:convert';

class VaccinationModel {
  DateTime? date;
  String? against;
  String? tradeName;
  String? immunizationType;

  VaccinationModel({
    this.against,
    this.date,
    this.immunizationType,
    this.tradeName,
  });

  Map<String, dynamic> toMap() {
    return {
      "against": against,
      "tradeName": tradeName,
      "immunizationType": immunizationType,
      "date": date!.toIso8601String(),
    };
  }

  factory VaccinationModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return VaccinationModel();
    }
    return VaccinationModel(
      against: map['against'],
      tradeName: map['tradeName'],
      immunizationType: map['immunizationType'],
      date: DateTime.parse(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory VaccinationModel.fromJson(String? source) =>
      VaccinationModel.fromMap(json.decode(source!));
}
