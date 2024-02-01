import 'dart:async';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hadith/core/features/verse_audio/domain/manager/background_service_manager.dart';
import 'package:hadith/features/esmaul_husna/data/esmaul_husna_widget_handler.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'core/data/local/instance.dart';
import 'features/app/my_app.dart';
import 'features/app/my_app_providers.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:home_widget/home_widget.dart';

Future<void> main() async {

  runZonedGuarded<Future<void>>(() async {

    WidgetsFlutterBinding.ensureInitialized();

    final database = await getDatabase();
    final sharedPreferences = await SharedPreferences.getInstance();

    await Firebase.initializeApp();
    MobileAds.instance.initialize();
    await BackgroundServiceManager.initService();

    HomeWidget.registerInteractivityCallback(backgroundCallback);

    if(!kDebugMode){
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
    }

    runApp(
      MyAppProviders(
        appDatabase: database,
        sharedPreferences: sharedPreferences,
        child: const MyApp(),
      )
    );
  }, (error, stack) {
    if(!kDebugMode){
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    }
  });
}


@pragma("vm:entry-point")
FutureOr<void> backgroundCallback(Uri? data) async {
  final host = data?.host;
  if(data?.scheme.toLowerCase() == "esmaulhusnawidget" && host != null){
    EsmaulHusnaWidgetHandler.handleWidget(host);
  }
}
