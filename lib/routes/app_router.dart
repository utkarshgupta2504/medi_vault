import 'package:auto_route/annotations.dart';
import 'package:medi_vault/screens/dashboard/dashboard_screen.dart';
import 'package:medi_vault/screens/dashboard/information/images_display_screen.dart';
import 'package:medi_vault/screens/profile/edit_profile_screen.dart';
import 'package:medi_vault/screens/splash_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: EditProfileScreen),
    AutoRoute(page: DashboardScreen),
    AutoRoute(page: ImagesDisplayScreen),
  ],
)
class $AppRouter {}
