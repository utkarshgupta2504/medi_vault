import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medi_vault/models/graph_data_model.dart';
import 'package:medi_vault/utils/app_logger.dart';
import 'package:medi_vault/utils/global.dart';
import 'package:medi_vault/utils/preferences.dart';

class GraphDataProvider extends ChangeNotifier {
  GraphDataModel? _bloodPressureData = GraphDataModel();
  GraphDataModel? _pulseData = GraphDataModel();
  GraphDataModel? _temperatureData = GraphDataModel();
  GraphDataModel? _bloodSugarData = GraphDataModel();
  GraphDataModel? _oxygenLevelData = GraphDataModel();

  Map<String, GraphDataModel?> get graphDataMap => {
        Global.bloodPressureData: _bloodPressureData,
        Global.bloodSugarData: _bloodSugarData,
        Global.oxygenLevelData: _oxygenLevelData,
        Global.pulseData: _pulseData,
        Global.temperatureData: _temperatureData,
      };

  GraphDataModel? get bloodPressureData => _bloodPressureData;
  GraphDataModel? get pulseData => _pulseData;
  GraphDataModel? get temperatureData => _temperatureData;
  GraphDataModel? get bloodSugarData => _bloodSugarData;
  GraphDataModel? get oxygenLevelData => _oxygenLevelData;

  Future<void> loadBloodPressureData({bool notify = true}) async {
    _bloodPressureData = Preference.hasKey(Global.bloodPressureData)
        ? GraphDataModel.fromJson(
            Preference.getString(Global.bloodPressureData)!)
        : GraphDataModel();

    AppLogger.print(_bloodPressureData.toString());

    if (notify) {
      notifyListeners();
      AppLogger.print("Blood Pressure Notified!");
    }
  }

  Future<void> loadPulseData({bool notify = true}) async {
    _pulseData = Preference.hasKey(Global.pulseData)
        ? GraphDataModel.fromJson(Preference.getString(Global.pulseData)!)
        : GraphDataModel();

    if (notify) {
      notifyListeners();
    }
  }

  Future<void> loadTemperatureData({bool notify = true}) async {
    _temperatureData = Preference.hasKey(Global.temperatureData)
        ? GraphDataModel.fromJson(Preference.getString(Global.temperatureData)!)
        : GraphDataModel();

    if (notify) {
      notifyListeners();
    }
  }

  Future<void> loadBloodSugarData({bool notify = true}) async {
    _bloodSugarData = Preference.hasKey(Global.bloodSugarData)
        ? GraphDataModel.fromJson(Preference.getString(Global.bloodSugarData)!)
        : GraphDataModel();

    if (notify) {
      notifyListeners();
    }
  }

  Future<void> loadOxygenLevelData({bool notify = true}) async {
    _oxygenLevelData = Preference.hasKey(Global.oxygenLevelData)
        ? GraphDataModel.fromJson(Preference.getString(Global.oxygenLevelData)!)
        : GraphDataModel();

    if (notify) {
      notifyListeners();
    }
  }

  Future<void> loadAllGraphs({bool notify = true}) async {
    await loadBloodPressureData(notify: notify);
    await loadBloodSugarData(notify: notify);
    await loadOxygenLevelData(notify: notify);
    await loadPulseData(notify: notify);
    await loadTemperatureData(notify: notify);

    notifyListeners();
  }

  Future<void> setData(
      {required String preferenceKey, required GraphDataModel data}) async {
    Preference.setString(preferenceKey, data.toJson());
  }
}
