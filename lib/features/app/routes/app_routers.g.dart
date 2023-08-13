// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routers.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $hadithAllRoute,
      $hadithTopicRoute,
      $hadithListRoute,
      $hadithSearchRoute,
      $archiveListRoute,
      $sectionRoute,
      $topicRoute,
      $cuzRoute,
      $surahRoute,
      $verseShowCuzRoute,
      $verseShowSurahRoute,
      $verseShowListRoute,
      $verseShowTopicRoute,
      $verseShowSearchRoute,
      $prayerAndVerseListRoute,
      $prayerAndVerseDetailRoute,
      $prayerInQuranRoute,
      $showEsmaulHusnaRoute,
      $esmaulHusnaDetailRoute,
    ];

RouteBase get $hadithAllRoute => GoRouteData.$route(
      path: '/hadith/all/:hadithBookId/:pos',
      factory: $HadithAllRouteExtension._fromState,
    );

extension $HadithAllRouteExtension on HadithAllRoute {
  static HadithAllRoute _fromState(GoRouterState state) => HadithAllRoute(
        hadithBookId: int.parse(state.pathParameters['hadithBookId']!),
        pos: _$convertMapValue('pos', state.queryParameters, int.parse) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/hadith/all/${Uri.encodeComponent(hadithBookId.toString())}/${Uri.encodeComponent(pos.toString())}',
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

RouteBase get $hadithTopicRoute => GoRouteData.$route(
      path: '/hadith/topic/:bookId/:topicId/:pos',
      factory: $HadithTopicRouteExtension._fromState,
    );

extension $HadithTopicRouteExtension on HadithTopicRoute {
  static HadithTopicRoute _fromState(GoRouterState state) => HadithTopicRoute(
        bookId: int.parse(state.pathParameters['bookId']!),
        topicId: int.parse(state.pathParameters['topicId']!),
        pos: _$convertMapValue('pos', state.queryParameters, int.parse) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/hadith/topic/${Uri.encodeComponent(bookId.toString())}/${Uri.encodeComponent(topicId.toString())}/${Uri.encodeComponent(pos.toString())}',
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
      path: '/hadith/list/:sourceId/:listId/:pos',
      factory: $HadithListRouteExtension._fromState,
    );

extension $HadithListRouteExtension on HadithListRoute {
  static HadithListRoute _fromState(GoRouterState state) => HadithListRoute(
        sourceId: int.parse(state.pathParameters['sourceId']!),
        listId: int.parse(state.pathParameters['listId']!),
        pos: _$convertMapValue('pos', state.queryParameters, int.parse) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/hadith/list/${Uri.encodeComponent(sourceId.toString())}/${Uri.encodeComponent(listId.toString())}/${Uri.encodeComponent(pos.toString())}',
        queryParams: {
          if (pos != 0) 'pos': pos.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $hadithSearchRoute => GoRouteData.$route(
      path: '/hadith/search/:query/:bookScopeId/:criteriaId/:pos',
      factory: $HadithSearchRouteExtension._fromState,
    );

extension $HadithSearchRouteExtension on HadithSearchRoute {
  static HadithSearchRoute _fromState(GoRouterState state) => HadithSearchRoute(
        query: state.pathParameters['query']!,
        bookScopeId: int.parse(state.pathParameters['bookScopeId']!),
        criteriaId: int.parse(state.pathParameters['criteriaId']!),
        pos: _$convertMapValue('pos', state.queryParameters, int.parse) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/hadith/search/${Uri.encodeComponent(query)}/${Uri.encodeComponent(bookScopeId.toString())}/${Uri.encodeComponent(criteriaId.toString())}/${Uri.encodeComponent(pos.toString())}',
        queryParams: {
          if (pos != 0) 'pos': pos.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
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

RouteBase get $verseShowCuzRoute => GoRouteData.$route(
      path: '/cuz/:cuzNo/:pos',
      factory: $VerseShowCuzRouteExtension._fromState,
    );

extension $VerseShowCuzRouteExtension on VerseShowCuzRoute {
  static VerseShowCuzRoute _fromState(GoRouterState state) => VerseShowCuzRoute(
        cuzNo: int.parse(state.pathParameters['cuzNo']!),
        pos: _$convertMapValue('pos', state.queryParameters, int.parse) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/cuz/${Uri.encodeComponent(cuzNo.toString())}/${Uri.encodeComponent(pos.toString())}',
        queryParams: {
          if (pos != 0) 'pos': pos.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $verseShowSurahRoute => GoRouteData.$route(
      path: '/surah/:surahId/:pos',
      factory: $VerseShowSurahRouteExtension._fromState,
    );

extension $VerseShowSurahRouteExtension on VerseShowSurahRoute {
  static VerseShowSurahRoute _fromState(GoRouterState state) =>
      VerseShowSurahRoute(
        surahId: int.parse(state.pathParameters['surahId']!),
        pos: _$convertMapValue('pos', state.queryParameters, int.parse) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/surah/${Uri.encodeComponent(surahId.toString())}/${Uri.encodeComponent(pos.toString())}',
        queryParams: {
          if (pos != 0) 'pos': pos.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $verseShowListRoute => GoRouteData.$route(
      path: '/verse/list/:sourceId/:listId/:pos',
      factory: $VerseShowListRouteExtension._fromState,
    );

extension $VerseShowListRouteExtension on VerseShowListRoute {
  static VerseShowListRoute _fromState(GoRouterState state) =>
      VerseShowListRoute(
        listId: int.parse(state.pathParameters['listId']!),
        sourceId: int.parse(state.pathParameters['sourceId']!),
        pos: _$convertMapValue('pos', state.queryParameters, int.parse) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/verse/list/${Uri.encodeComponent(sourceId.toString())}/${Uri.encodeComponent(listId.toString())}/${Uri.encodeComponent(pos.toString())}',
        queryParams: {
          if (pos != 0) 'pos': pos.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $verseShowTopicRoute => GoRouteData.$route(
      path: '/verse/topic/:bookId/:topicId/:pos',
      factory: $VerseShowTopicRouteExtension._fromState,
    );

extension $VerseShowTopicRouteExtension on VerseShowTopicRoute {
  static VerseShowTopicRoute _fromState(GoRouterState state) =>
      VerseShowTopicRoute(
        topicId: int.parse(state.pathParameters['topicId']!),
        bookId: int.parse(state.pathParameters['bookId']!),
        pos: _$convertMapValue('pos', state.queryParameters, int.parse) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/verse/topic/${Uri.encodeComponent(bookId.toString())}/${Uri.encodeComponent(topicId.toString())}/${Uri.encodeComponent(pos.toString())}',
        queryParams: {
          if (pos != 0) 'pos': pos.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $verseShowSearchRoute => GoRouteData.$route(
      path: '/verse/search/:query/:bookScopeId/:criteriaId/:pos',
      factory: $VerseShowSearchRouteExtension._fromState,
    );

extension $VerseShowSearchRouteExtension on VerseShowSearchRoute {
  static VerseShowSearchRoute _fromState(GoRouterState state) =>
      VerseShowSearchRoute(
        query: state.pathParameters['query']!,
        bookScopeId: int.parse(state.pathParameters['bookScopeId']!),
        criteriaId: int.parse(state.pathParameters['criteriaId']!),
        pos: _$convertMapValue('pos', state.queryParameters, int.parse) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/verse/search/${Uri.encodeComponent(query)}/${Uri.encodeComponent(bookScopeId.toString())}/${Uri.encodeComponent(criteriaId.toString())}/${Uri.encodeComponent(pos.toString())}',
        queryParams: {
          if (pos != 0) 'pos': pos.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $prayerAndVerseListRoute => GoRouteData.$route(
      path: '/prayerverse/list',
      factory: $PrayerAndVerseListRouteExtension._fromState,
    );

extension $PrayerAndVerseListRouteExtension on PrayerAndVerseListRoute {
  static PrayerAndVerseListRoute _fromState(GoRouterState state) =>
      PrayerAndVerseListRoute();

  String get location => GoRouteData.$location(
        '/prayerverse/list',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $prayerAndVerseDetailRoute => GoRouteData.$route(
      path: '/prayerverse/detail/:prayerId',
      factory: $PrayerAndVerseDetailRouteExtension._fromState,
    );

extension $PrayerAndVerseDetailRouteExtension on PrayerAndVerseDetailRoute {
  static PrayerAndVerseDetailRoute _fromState(GoRouterState state) =>
      PrayerAndVerseDetailRoute(
        prayerId: int.parse(state.pathParameters['prayerId']!),
      );

  String get location => GoRouteData.$location(
        '/prayerverse/detail/${Uri.encodeComponent(prayerId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $prayerInQuranRoute => GoRouteData.$route(
      path: '/prayerinqurans',
      factory: $PrayerInQuranRouteExtension._fromState,
    );

extension $PrayerInQuranRouteExtension on PrayerInQuranRoute {
  static PrayerInQuranRoute _fromState(GoRouterState state) =>
      PrayerInQuranRoute();

  String get location => GoRouteData.$location(
        '/prayerinqurans',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $showEsmaulHusnaRoute => GoRouteData.$route(
      path: '/esmaulHusna/:pos',
      factory: $ShowEsmaulHusnaRouteExtension._fromState,
    );

extension $ShowEsmaulHusnaRouteExtension on ShowEsmaulHusnaRoute {
  static ShowEsmaulHusnaRoute _fromState(GoRouterState state) =>
      ShowEsmaulHusnaRoute(
        pos: _$convertMapValue('pos', state.queryParameters, int.parse) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/esmaulHusna/${Uri.encodeComponent(pos.toString())}',
        queryParams: {
          if (pos != 0) 'pos': pos.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $esmaulHusnaDetailRoute => GoRouteData.$route(
      path: '/esmaulHusna/detail/:pos',
      factory: $EsmaulHusnaDetailRouteExtension._fromState,
    );

extension $EsmaulHusnaDetailRouteExtension on EsmaulHusnaDetailRoute {
  static EsmaulHusnaDetailRoute _fromState(GoRouterState state) =>
      EsmaulHusnaDetailRoute(
        pos: int.parse(state.pathParameters['pos']!),
      );

  String get location => GoRouteData.$location(
        '/esmaulHusna/detail/${Uri.encodeComponent(pos.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}
