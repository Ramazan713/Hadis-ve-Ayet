// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routers.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $hadithAllRoute,
      $sectionRoute,
      $topicRoute,
    ];

RouteBase get $hadithAllRoute => GoRouteData.$route(
      path: '/all_hadiths/:hadithBookId',
      factory: $HadithAllRouteExtension._fromState,
    );

extension $HadithAllRouteExtension on HadithAllRoute {
  static HadithAllRoute _fromState(GoRouterState state) => HadithAllRoute(
        hadithBookId: int.parse(state.pathParameters['hadithBookId']!),
      );

  String get location => GoRouteData.$location(
        '/all_hadiths/${Uri.encodeComponent(hadithBookId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $sectionRoute => GoRouteData.$route(
      path: '/section/:bookId',
      factory: $SectionRouteExtension._fromState,
    );

extension $SectionRouteExtension on SectionRoute {
  static SectionRoute _fromState(GoRouterState state) => SectionRoute(
        bookId: int.parse(state.pathParameters['bookId']!),
      );

  String get location => GoRouteData.$location(
        '/section/${Uri.encodeComponent(bookId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $topicRoute => GoRouteData.$route(
      path: '/topic/:bookId/:sectionId/:sectionTitle/:useBookAllSections',
      factory: $TopicRouteExtension._fromState,
    );

extension $TopicRouteExtension on TopicRoute {
  static TopicRoute _fromState(GoRouterState state) => TopicRoute(
        bookId: int.parse(state.pathParameters['bookId']!),
        sectionId: int.parse(state.pathParameters['sectionId']!),
        sectionTitle: state.pathParameters['sectionTitle']!,
        useBookAllSections:
            _$boolConverter(state.pathParameters['useBookAllSections']!),
      );

  String get location => GoRouteData.$location(
        '/topic/${Uri.encodeComponent(bookId.toString())}/${Uri.encodeComponent(sectionId.toString())}/${Uri.encodeComponent(sectionTitle)}/${Uri.encodeComponent(useBookAllSections.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

bool _$boolConverter(String value) {
  switch (value) {
    case 'true':
      return true;
    case 'false':
      return false;
    default:
      throw UnsupportedError('Cannot convert "$value" into a bool.');
  }
}
