// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_nav_routers.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $bottomBarRouteData,
    ];

RouteBase get $bottomBarRouteData => ShellRouteData.$route(
      factory: $BottomBarRouteDataExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/search',
          factory: $SearchRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/home',
          factory: $HomeRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/categories',
          factory: $CategoriesRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/show_list',
          factory: $ShowListRouteExtension._fromState,
        ),
      ],
    );

extension $BottomBarRouteDataExtension on BottomBarRouteData {
  static BottomBarRouteData _fromState(GoRouterState state) =>
      BottomBarRouteData();
}

extension $SearchRouteExtension on SearchRoute {
  static SearchRoute _fromState(GoRouterState state) => SearchRoute();

  String get location => GoRouteData.$location(
        '/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $CategoriesRouteExtension on CategoriesRoute {
  static CategoriesRoute _fromState(GoRouterState state) => CategoriesRoute();

  String get location => GoRouteData.$location(
        '/categories',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $ShowListRouteExtension on ShowListRoute {
  static ShowListRoute _fromState(GoRouterState state) => ShowListRoute();

  String get location => GoRouteData.$location(
        '/show_list',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}
