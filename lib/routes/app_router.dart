import 'package:auto_route/annotations.dart';
import 'package:medi_vault/screens/splash_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashScreen, initial: true),
  ],
)
class $AppRouter {}
