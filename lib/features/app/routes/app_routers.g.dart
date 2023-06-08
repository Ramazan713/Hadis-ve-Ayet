// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routers.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $hadithAllRoute,
      $archiveListRoute,
      $sectionRoute,
      $topicRoute,
      $hadithTopicRoute,
      $hadithListRoute,
      $cuzRoute,
      $surahRoute,
    ];

RouteBase get $hadithAllRoute => GoRouteData.$route(
      path: '/all_hadiths/:hadithBookId/:pos',
      factory: $HadithAllRouteExtension._fromState,
    );

extension $HadithAllRouteExtension on HadithAllRoute {
  static HadithAllRoute _fromState(GoRouterState state) => HadithAllRoute(
        hadithBookId: int.parse(state.pathParameters['hadithBookId']!),
        pos: _$convertMapValue('pos', state.queryParameters, int.parse) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/all_hadiths/${Uri.encodeComponent(hadithBookId.toString())}/${Uri.encodeComponent(pos.toString())}',
        queryParams: {
          if (pos != 0) 'pos': pos.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

RouteBase get $archiveListRoute => GoRouteData.$route(
      path: '/archiveList',
      factory: $ArchiveListRouteExtension._fromState,
    );

extension $ArchiveListRouteExtension on ArchiveListRoute {
  static ArchiveListRoute _fromState(GoRouterState state) => ArchiveListRoute();

  String get location => GoRouteData.$location(
        '/archiveList',
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
      path: '/hadithTopic/:bookId/:topicId/:pos',
      factory: $HadithTopicRouteExtension._fromState,
    );

extension $HadithTopicRouteExtension on HadithTopicRoute {
  static HadithTopicRoute _fromState(GoRouterState state) => HadithTopicRoute(
        bookId: int.parse(state.pathParameters['bookId']!),
        topicId: int.parse(state.pathParameters['topicId']!),
        pos: _$convertMapValue('pos', state.queryParameters, int.parse) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/hadithTopic/${Uri.encodeComponent(bookId.toString())}/${Uri.encodeComponent(topicId.toString())}/${Uri.encodeComponent(pos.toString())}',
        queryParams: {
          if (pos != 0) 'pos': pos.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $hadithListRoute => GoRouteData.$route(
      path: '/hadithList/:listBookId/:listId/:pos',
      factory: $HadithListRouteExtension._fromState,
    );

extension $HadithListRouteExtension on HadithListRoute {
  static HadithListRoute _fromState(GoRouterState state) => HadithListRoute(
        listBookId: int.parse(state.pathParameters['listBookId']!),
        listId: int.parse(state.pathParameters['listId']!),
        pos: _$convertMapValue('pos', state.queryParameters, int.parse) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/hadithList/${Uri.encodeComponent(listBookId.toString())}/${Uri.encodeComponent(listId.toString())}/${Uri.encodeComponent(pos.toString())}',
        queryParams: {
          if (pos != 0) 'pos': pos.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $cuzRoute => GoRouteData.$route(
      path: '/cuz',
      factory: $CuzRouteExtension._fromState,
    );

extension $CuzRouteExtension on CuzRoute {
  static CuzRoute _fromState(GoRouterState state) => CuzRoute();

  String get location => GoRouteData.$location(
        '/cuz',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $surahRoute => GoRouteData.$route(
      path: '/surah',
      factory: $SurahRouteExtension._fromState,
    );

extension $SurahRouteExtension on SurahRoute {
  static SurahRoute _fromState(GoRouterState state) => SurahRoute();

  String get location => GoRouteData.$location(
        '/surah',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}
