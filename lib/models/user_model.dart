import 'dart:convert';

class UserModel {
  final String? name;
  final DateTime? dob;
  final String? gender;
  final double? weight;
  final double? height;

  UserModel({this.dob, this.gender, this.height, this.name, this.weight});

  UserModel copywith({
    String? name,
    DateTime? dob,
    String? gender,
    double? weight,
    double? height,
  }) {
    return UserModel(
      name: name ?? this.name,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      height: height ?? this.height,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dob': dob,
      'gender': gender,
      'weight': weight,
      'height': height,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      dob: map['dob'],
      gender: map['gender'],
      weight: map['weight'],
      height: map['height'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, dob: ${dob.toString()}, gender: $gender, weight: $weight, height: $height)';
  }
}
