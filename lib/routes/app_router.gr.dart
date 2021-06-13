// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../screens/dashboard/dashboard_screen.dart' as _i5;
import '../screens/dashboard/information/images_display_screen.dart' as _i6;
import '../screens/dashboard/information/information_detail_screen.dart' as _i7;
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
        }),
    ImagesDisplayScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ImagesDisplayScreenRouteArgs>();
          return _i6.ImagesDisplayScreen(
              key: args.key, title: args.title, imagesList: args.imagesList);
        }),
    InformationDetailScreenRoute.name: (routeData) =>
        _i1.MaterialPageX<dynamic>(
            routeData: routeData,
            builder: (data) {
              final args = data.argsAs<InformationDetailScreenRouteArgs>();
              return _i7.InformationDetailScreen(
                  key: args.key,
                  createCard: args.createCard,
                  informationList: args.informationList,
                  title: args.title);
            })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i1.RouteConfig(EditProfileScreenRoute.name,
            path: '/edit-profile-screen'),
        _i1.RouteConfig(DashboardScreenRoute.name, path: '/dashboard-screen'),
        _i1.RouteConfig(ImagesDisplayScreenRoute.name,
            path: '/images-display-screen'),
        _i1.RouteConfig(InformationDetailScreenRoute.name,
            path: '/information-detail-screen')
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

class ImagesDisplayScreenRoute
    extends _i1.PageRouteInfo<ImagesDisplayScreenRouteArgs> {
  ImagesDisplayScreenRoute(
      {_i2.Key? key, required String title, required List<dynamic>? imagesList})
      : super(name,
            path: '/images-display-screen',
            args: ImagesDisplayScreenRouteArgs(
                key: key, title: title, imagesList: imagesList));

  static const String name = 'ImagesDisplayScreenRoute';
}

class ImagesDisplayScreenRouteArgs {
  const ImagesDisplayScreenRouteArgs(
      {this.key, required this.title, required this.imagesList});

  final _i2.Key? key;

  final String title;

  final List<dynamic>? imagesList;
}

class InformationDetailScreenRoute
    extends _i1.PageRouteInfo<InformationDetailScreenRouteArgs> {
  InformationDetailScreenRoute(
      {_i2.Key? key,
      required _i2.Widget Function(dynamic) createCard,
      required List<dynamic>? informationList,
      required String title})
      : super(name,
            path: '/information-detail-screen',
            args: InformationDetailScreenRouteArgs(
                key: key,
                createCard: createCard,
                informationList: informationList,
                title: title));

  static const String name = 'InformationDetailScreenRoute';
}

class InformationDetailScreenRouteArgs {
  const InformationDetailScreenRouteArgs(
      {this.key,
      required this.createCard,
      required this.informationList,
      required this.title});

  final _i2.Key? key;

  final _i2.Widget Function(dynamic) createCard;

  final List<dynamic>? informationList;

  final String title;
}
