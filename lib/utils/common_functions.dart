import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:medi_vault/utils/preferences.dart';

void showSnackbar(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    fontSize: 16.0,
  );
}

List<dynamic> getInformationList(String preferenceKey) {
  if (Preference.hasKey(preferenceKey)) {
    return jsonDecode(Preference.getString(preferenceKey)!);
  }
  return [];
}

void updateInformationList(String preferenceKey, dynamic data) {
  List<dynamic> prevValues = getInformationList(preferenceKey);
  prevValues.add(data);
  Preference.setString(preferenceKey, jsonEncode(prevValues));
}
