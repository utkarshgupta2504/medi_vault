import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medi_vault/models/user_model.dart';
import 'package:medi_vault/utils/global.dart';
import 'package:medi_vault/utils/preferences.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> getUser() async {
    if (Preference.hasKey(Global.userProfileDetails)) {
      _user =
          UserModel.fromJson(Preference.getString(Global.userProfileDetails));
    } else {
      _user = UserModel();
    }

    notifyListeners();
  }

  Future<void> updateUser(Map<String, dynamic> data) async {
    Preference.setString(Global.userProfileDetails, jsonEncode(data));
    await getUser();
  }
}
