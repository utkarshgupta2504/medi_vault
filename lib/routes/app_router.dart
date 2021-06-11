import 'package:auto_route/annotations.dart';
import 'package:medi_vault/screens/dashboard/dashboard_screen.dart';
import 'package:medi_vault/screens/profile/edit_profile_screen.dart';
import 'package:medi_vault/screens/splash_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: EditProfileScreen),
    MaterialRoute(page: DashboardScreen),
  ],
)
class $AppRouter {}
