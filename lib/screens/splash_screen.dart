import 'package:flutter/material.dart';
import 'package:medi_vault/utils/app_logger.dart';
import 'package:medi_vault/utils/preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  initialise() async {
    try {
      await Preference.load();
      await Future.delayed(Duration(seconds: 2));
      AppLogger.print("Proceed from splash screen");
    } catch (e) {
      AppLogger.print("splash Screen error : " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    initialise();
    return Container(
      child: Center(
        child: Image.asset("assets/bg.jpeg"),
      ),
    );
  }
}
