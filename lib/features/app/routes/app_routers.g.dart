// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routers.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $hadithAllRoute,
      $hadithTopicRoute,
      $searchRoute,
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
      $customPrayersRoute,
      $customPrayerDetailRoute,
      $addCustomPrayerRoute,
      $updateCustomPrayerRoute,
      $showEsmaulHusnaRoute,
      $esmaulHusnaDetailRoute,
      $showCountersRoute,
      $detailCounterRoute,
      $detailCounterEmptyRoute,
      $counterSettingRoute,
      $addNewCounterRoute,
      $manageCounterRoute,
      $efaliMukellefinRoute,
      $fardsInfoRoute,
      $adjectiveOfAllahRoute,
      $settingsRoute,
      $settingsAudioRoute,
    ];

RouteBase get $hadithAllRoute => GoRouteData.$route(
      path: '/hadith/all/:hadithBookId/:pos',
      factory: $HadithAllRouteExtension._fromState,
    );

extension $HadithAllRouteExtension on HadithAllRoute {
  static HadithAllRoute _fromState(GoRouterState state) => HadithAllRoute(
        hadithBookId: int.parse(state.pathParameters['hadithBookId']!),
        pos: int.parse(state.pathParameters['pos']!) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/hadith/all/${Uri.encodeComponent(hadithBookId.toString())}/${Uri.encodeComponent(pos.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $hadithTopicRoute => GoRouteData.$route(
      path: '/hadith/topic/:bookId/:topicId/:pos',
      factory: $HadithTopicRouteExtension._fromState,
    );

extension $HadithTopicRouteExtension on HadithTopicRoute {
  static HadithTopicRoute _fromState(GoRouterState state) => HadithTopicRoute(
        bookId: int.parse(state.pathParameters['bookId']!),
        topicId: int.parse(state.pathParameters['topicId']!),
        pos: int.parse(state.pathParameters['pos']!) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/hadith/topic/${Uri.encodeComponent(bookId.toString())}/${Uri.encodeComponent(topicId.toString())}/${Uri.encodeComponent(pos.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $searchRoute => GoRouteData.$route(
      path: '/search',
      factory: $SearchRouteExtension._fromState,
    );

extension $SearchRouteExtension on SearchRoute {
  static SearchRoute _fromState(GoRouterState state) => SearchRoute();

  String get location => GoRouteData.$location(
        '/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $hadithListRoute => GoRouteData.$route(
      path: '/hadith/list/:sourceId/:listId/:pos',
      factory: $HadithListRouteExtension._fromState,
    );

extension $HadithListRouteExtension on HadithListRoute {
  static HadithListRoute _fromState(GoRouterState state) => HadithListRoute(
        sourceId: int.parse(state.pathParameters['sourceId']!),
        listId: int.parse(state.pathParameters['listId']!),
        pos: int.parse(state.pathParameters['pos']!) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/hadith/list/${Uri.encodeComponent(sourceId.toString())}/${Uri.encodeComponent(listId.toString())}/${Uri.encodeComponent(pos.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
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
        pos: int.parse(state.pathParameters['pos']!) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/hadith/search/${Uri.encodeComponent(query)}/${Uri.encodeComponent(bookScopeId.toString())}/${Uri.encodeComponent(criteriaId.toString())}/${Uri.encodeComponent(pos.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
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

  void replace(BuildContext context) => context.replace(location);
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

  void replace(BuildContext context) => context.replace(location);
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

  void replace(BuildContext context) => context.replace(location);
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

  void replace(BuildContext context) => context.replace(location);
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

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $verseShowCuzRoute => GoRouteData.$route(
      path: '/cuz/:cuzNo/:pos',
      factory: $VerseShowCuzRouteExtension._fromState,
    );

extension $VerseShowCuzRouteExtension on VerseShowCuzRoute {
  static VerseShowCuzRoute _fromState(GoRouterState state) => VerseShowCuzRoute(
        cuzNo: int.parse(state.pathParameters['cuzNo']!),
        pos: int.parse(state.pathParameters['pos']!) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/cuz/${Uri.encodeComponent(cuzNo.toString())}/${Uri.encodeComponent(pos.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $verseShowSurahRoute => GoRouteData.$route(
      path: '/surah/:surahId/:pos',
      factory: $VerseShowSurahRouteExtension._fromState,
    );

extension $VerseShowSurahRouteExtension on VerseShowSurahRoute {
  static VerseShowSurahRoute _fromState(GoRouterState state) =>
      VerseShowSurahRoute(
        surahId: int.parse(state.pathParameters['surahId']!),
        pos: int.parse(state.pathParameters['pos']!) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/surah/${Uri.encodeComponent(surahId.toString())}/${Uri.encodeComponent(pos.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
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
        pos: int.parse(state.pathParameters['pos']!) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/verse/list/${Uri.encodeComponent(sourceId.toString())}/${Uri.encodeComponent(listId.toString())}/${Uri.encodeComponent(pos.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
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
        pos: int.parse(state.pathParameters['pos']!) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/verse/topic/${Uri.encodeComponent(bookId.toString())}/${Uri.encodeComponent(topicId.toString())}/${Uri.encodeComponent(pos.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
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
        pos: int.parse(state.pathParameters['pos']!) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/verse/search/${Uri.encodeComponent(query)}/${Uri.encodeComponent(bookScopeId.toString())}/${Uri.encodeComponent(criteriaId.toString())}/${Uri.encodeComponent(pos.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
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

  void replace(BuildContext context) => context.replace(location);
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

  void replace(BuildContext context) => context.replace(location);
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

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $customPrayersRoute => GoRouteData.$route(
      path: '/prayers/custom',
      factory: $CustomPrayersRouteExtension._fromState,
    );

extension $CustomPrayersRouteExtension on CustomPrayersRoute {
  static CustomPrayersRoute _fromState(GoRouterState state) =>
      CustomPrayersRoute();

  String get location => GoRouteData.$location(
        '/prayers/custom',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $customPrayerDetailRoute => GoRouteData.$route(
      path: '/prayers/custom/detail/:prayerId',
      factory: $CustomPrayerDetailRouteExtension._fromState,
    );

extension $CustomPrayerDetailRouteExtension on CustomPrayerDetailRoute {
  static CustomPrayerDetailRoute _fromState(GoRouterState state) =>
      CustomPrayerDetailRoute(
        prayerId: int.parse(state.pathParameters['prayerId']!),
      );

  String get location => GoRouteData.$location(
        '/prayers/custom/detail/${Uri.encodeComponent(prayerId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $addCustomPrayerRoute => GoRouteData.$route(
      path: '/prayers/custom/add',
      factory: $AddCustomPrayerRouteExtension._fromState,
    );

extension $AddCustomPrayerRouteExtension on AddCustomPrayerRoute {
  static AddCustomPrayerRoute _fromState(GoRouterState state) =>
      AddCustomPrayerRoute();

  String get location => GoRouteData.$location(
        '/prayers/custom/add',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $updateCustomPrayerRoute => GoRouteData.$route(
      path: '/prayers/custom/update/:prayerId',
      factory: $UpdateCustomPrayerRouteExtension._fromState,
    );

extension $UpdateCustomPrayerRouteExtension on UpdateCustomPrayerRoute {
  static UpdateCustomPrayerRoute _fromState(GoRouterState state) =>
      UpdateCustomPrayerRoute(
        prayerId: int.parse(state.pathParameters['prayerId']!),
      );

  String get location => GoRouteData.$location(
        '/prayers/custom/update/${Uri.encodeComponent(prayerId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $showEsmaulHusnaRoute => GoRouteData.$route(
      path: '/esmaulHusna/:pos',
      factory: $ShowEsmaulHusnaRouteExtension._fromState,
    );

extension $ShowEsmaulHusnaRouteExtension on ShowEsmaulHusnaRoute {
  static ShowEsmaulHusnaRoute _fromState(GoRouterState state) =>
      ShowEsmaulHusnaRoute(
        pos: int.parse(state.pathParameters['pos']!) ?? 0,
      );

  String get location => GoRouteData.$location(
        '/esmaulHusna/${Uri.encodeComponent(pos.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
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

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $showCountersRoute => GoRouteData.$route(
      path: '/counters',
      factory: $ShowCountersRouteExtension._fromState,
    );

extension $ShowCountersRouteExtension on ShowCountersRoute {
  static ShowCountersRoute _fromState(GoRouterState state) =>
      ShowCountersRoute();

  String get location => GoRouteData.$location(
        '/counters',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $detailCounterRoute => GoRouteData.$route(
      path: '/counters/detail/:id',
      factory: $DetailCounterRouteExtension._fromState,
    );

extension $DetailCounterRouteExtension on DetailCounterRoute {
  static DetailCounterRoute _fromState(GoRouterState state) =>
      DetailCounterRoute(
        id: int.parse(state.pathParameters['id']!),
      );

  String get location => GoRouteData.$location(
        '/counters/detail/${Uri.encodeComponent(id.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $detailCounterEmptyRoute => GoRouteData.$route(
      path: '/counters/detail/empty/:counterTypeId',
      factory: $DetailCounterEmptyRouteExtension._fromState,
    );

extension $DetailCounterEmptyRouteExtension on DetailCounterEmptyRoute {
  static DetailCounterEmptyRoute _fromState(GoRouterState state) =>
      DetailCounterEmptyRoute(
        counterTypeId: int.parse(state.pathParameters['counterTypeId']!),
      );

  String get location => GoRouteData.$location(
        '/counters/detail/empty/${Uri.encodeComponent(counterTypeId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $counterSettingRoute => GoRouteData.$route(
      path: '/counters/setting',
      factory: $CounterSettingRouteExtension._fromState,
    );

extension $CounterSettingRouteExtension on CounterSettingRoute {
  static CounterSettingRoute _fromState(GoRouterState state) =>
      CounterSettingRoute();

  String get location => GoRouteData.$location(
        '/counters/setting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $addNewCounterRoute => GoRouteData.$route(
      path: '/counters/addNewCounter',
      factory: $AddNewCounterRouteExtension._fromState,
    );

extension $AddNewCounterRouteExtension on AddNewCounterRoute {
  static AddNewCounterRoute _fromState(GoRouterState state) =>
      AddNewCounterRoute();

  String get location => GoRouteData.$location(
        '/counters/addNewCounter',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $manageCounterRoute => GoRouteData.$route(
      path: '/counters/manageCounter/:counterId',
      factory: $ManageCounterRouteExtension._fromState,
    );

extension $ManageCounterRouteExtension on ManageCounterRoute {
  static ManageCounterRoute _fromState(GoRouterState state) =>
      ManageCounterRoute(
        counterId: int.parse(state.pathParameters['counterId']!),
      );

  String get location => GoRouteData.$location(
        '/counters/manageCounter/${Uri.encodeComponent(counterId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $efaliMukellefinRoute => GoRouteData.$route(
      path: '/islamicInfo/efaliMukellefin',
      factory: $EfaliMukellefinRouteExtension._fromState,
    );

extension $EfaliMukellefinRouteExtension on EfaliMukellefinRoute {
  static EfaliMukellefinRoute _fromState(GoRouterState state) =>
      EfaliMukellefinRoute();

  String get location => GoRouteData.$location(
        '/islamicInfo/efaliMukellefin',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $fardsInfoRoute => GoRouteData.$route(
      path: '/islamicInfo/fards/:fardsTypeId',
      factory: $FardsInfoRouteExtension._fromState,
    );

extension $FardsInfoRouteExtension on FardsInfoRoute {
  static FardsInfoRoute _fromState(GoRouterState state) => FardsInfoRoute(
        fardsTypeId: int.parse(state.pathParameters['fardsTypeId']!),
      );

  String get location => GoRouteData.$location(
        '/islamicInfo/fards/${Uri.encodeComponent(fardsTypeId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adjectiveOfAllahRoute => GoRouteData.$route(
      path: '/islamicInfo/adjectiveOfAllah',
      factory: $AdjectiveOfAllahRouteExtension._fromState,
    );

extension $AdjectiveOfAllahRouteExtension on AdjectiveOfAllahRoute {
  static AdjectiveOfAllahRoute _fromState(GoRouterState state) =>
      AdjectiveOfAllahRoute();

  String get location => GoRouteData.$location(
        '/islamicInfo/adjectiveOfAllah',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsRoute => GoRouteData.$route(
      path: '/settings',
      factory: $SettingsRouteExtension._fromState,
    );

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => SettingsRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsAudioRoute => GoRouteData.$route(
      path: '/settings/audio',
      factory: $SettingsAudioRouteExtension._fromState,
    );

extension $SettingsAudioRouteExtension on SettingsAudioRoute {
  static SettingsAudioRoute _fromState(GoRouterState state) =>
      SettingsAudioRoute();

  String get location => GoRouteData.$location(
        '/settings/audio',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
