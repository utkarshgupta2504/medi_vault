import 'dart:convert';

class GraphDataModel {
  Map<DateTime, double>? data;

  GraphDataModel({this.data});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> res = {};

    if (data == null) {
      return res;
    }

    data!.forEach((key, value) {
      res[key.toIso8601String()] = value;
    });

    return res;
  }

  factory GraphDataModel.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return GraphDataModel();
    } else {
      Map<DateTime, double> res = {};

      map.forEach((key, value) {
        res[DateTime.parse(key)] = value;
      });

      return GraphDataModel(data: res);
    }
  }

  String toJson() => json.encode(toMap());

  factory GraphDataModel.fromJson(String? source) =>
      GraphDataModel.fromMap(json.decode(source!));

  @override
  String toString() {
    return "GraphDataModel(data: ${data.toString()})";
  }
}
