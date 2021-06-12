import 'dart:core';

class Global {
  static String appName = "Medi Vault";

  ///////////Shared Preference Keys

  ///Profile Keys
  static String profileSet = "profile_set";
  static String userProfileDetails = "user_profile_details";
  static String profilePhoto = "profile_photo";

  ///Graph Data Keys
  static String bloodPressureData = "blood_pressure_data";
  static String pulseData = "pulse_data";
  static String oxygenLevelData = "oxygen_level_data";
  static String bloodSugarData = "blood_sugar_data";
  static String temperatureData = "temperature_data";

  ///Information Keys
  static String prescriptionInformation = "prescription_information";
  static String historyInformation = "history_information";
  static String medicationInformation = "medication_information";
  static String diseaseInformation = "disease_information";
  static String allergyInformation = "allergy_information";
  static String vaccinationInformation = "vaccination_information";
}
