import 'dart:convert';

class AllergyModel {
  String? item;
  String? reaction;

  AllergyModel({this.item, this.reaction});

  Map<String, dynamic> toMap() {
    return {
      "item": item,
      "reaction": reaction,
    };
  }

  factory AllergyModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return AllergyModel();
    }
    return AllergyModel(
      item: map['item'],
      reaction: map['reaction'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AllergyModel.fromJson(String? source) =>
      AllergyModel.fromMap(json.decode(source!));
}
