import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medi_vault/routes/app_router.gr.dart';
import 'package:medi_vault/utils/app_logger.dart';
import 'package:medi_vault/utils/global.dart';
import 'package:medi_vault/utils/preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isInitializerCalled = false;

  initialise() async {
    if (isInitializerCalled) {
      print('----------- initializer called : true ///// -> returning ');
      return;
    }
    isInitializerCalled = true;
    try {
      await Preference.load();
      await Future.delayed(Duration(seconds: 2));
      AppLogger.print("Proceed from splash screen");

      if (Preference.getBool(Global.profileSet)) {
        context.router.root.replace(DashboardScreenRoute());
      } else {
        context.router.root.replace(EditProfileScreenRoute(isStarting: true));
      }
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
