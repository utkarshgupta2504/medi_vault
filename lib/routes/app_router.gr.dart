// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../screens/dashboard/dashboard_screen.dart' as _i5;
import '../screens/profile/edit_profile_screen.dart' as _i4;
import '../screens/splash_screen.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.SplashScreen();
        }),
    EditProfileScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<EditProfileScreenRouteArgs>(
              orElse: () => const EditProfileScreenRouteArgs());
          return _i4.EditProfileScreen(
              key: args.key, isStarting: args.isStarting);
        }),
    DashboardScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.DashboardScreen();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i1.RouteConfig(EditProfileScreenRoute.name,
            path: '/edit-profile-screen'),
        _i1.RouteConfig(DashboardScreenRoute.name, path: '/dashboard-screen')
      ];
}

class SplashScreenRoute extends _i1.PageRouteInfo {
  const SplashScreenRoute() : super(name, path: '/');

  static const String name = 'SplashScreenRoute';
}

class EditProfileScreenRoute
    extends _i1.PageRouteInfo<EditProfileScreenRouteArgs> {
  EditProfileScreenRoute({_i2.Key? key, bool isStarting = false})
      : super(name,
            path: '/edit-profile-screen',
            args: EditProfileScreenRouteArgs(key: key, isStarting: isStarting));

  static const String name = 'EditProfileScreenRoute';
}

class EditProfileScreenRouteArgs {
  const EditProfileScreenRouteArgs({this.key, this.isStarting = false});

  final _i2.Key? key;

  final bool isStarting;
}

class DashboardScreenRoute extends _i1.PageRouteInfo {
  const DashboardScreenRoute() : super(name, path: '/dashboard-screen');

  static const String name = 'DashboardScreenRoute';
}
