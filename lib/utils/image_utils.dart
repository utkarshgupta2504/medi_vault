import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:medi_vault/utils/preferences.dart';

class ImageUtility {
  //
  static const String KEY = "IMAGE_KEY";

  static Future<String?> getImageFromPreferences() async {
    return Preference.getString(KEY);
  }

  static void saveImageToPreferences(String value) {
    Preference.setString(KEY, value);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
