// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routers.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $hadithAllRoute,
      $sectionRoute,
      $topicRoute,
      $hadithTopicRoute,
      $hadithListRoute,
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

RouteBase get $hadithTopicRoute => GoRouteData.$route(
      path: '/hadithTopic/:bookId/:topicId/:topicName',
      factory: $HadithTopicRouteExtension._fromState,
    );

extension $HadithTopicRouteExtension on HadithTopicRoute {
  static HadithTopicRoute _fromState(GoRouterState state) => HadithTopicRoute(
        bookId: int.parse(state.pathParameters['bookId']!),
        topicId: int.parse(state.pathParameters['topicId']!),
        topicName: state.pathParameters['topicName']!,
      );

  String get location => GoRouteData.$location(
        '/hadithTopic/${Uri.encodeComponent(bookId.toString())}/${Uri.encodeComponent(topicId.toString())}/${Uri.encodeComponent(topicName)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $hadithListRoute => GoRouteData.$route(
      path: '/hadithList/:listBookId/:listId/:listName',
      factory: $HadithListRouteExtension._fromState,
    );

extension $HadithListRouteExtension on HadithListRoute {
  static HadithListRoute _fromState(GoRouterState state) => HadithListRoute(
        listBookId: int.parse(state.pathParameters['listBookId']!),
        listId: int.parse(state.pathParameters['listId']!),
        listName: state.pathParameters['listName']!,
      );

  String get location => GoRouteData.$location(
        '/hadithList/${Uri.encodeComponent(listBookId.toString())}/${Uri.encodeComponent(listId.toString())}/${Uri.encodeComponent(listName)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}
