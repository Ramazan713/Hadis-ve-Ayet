import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hadith/core/data/preferences/app_preferences_impl.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/features/verses/shared/domain/manager/background_service_manager.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'db/instance.dart';
import 'features/app/my_app.dart';
import 'features/app/my_app_providers.dart';


Future<void> main() async {

  runZonedGuarded<Future<void>>(() async {

    WidgetsFlutterBinding.ensureInitialized();


    final database = await getDatabase();

    await LocalStorage.initStorage();
    await Firebase.initializeApp();

    MobileAds.instance.initialize();
    await BackgroundServiceManager.initService();

    // FlutterError.onError =
    //     FirebaseCrashlytics.instance.recordFlutterFatalError;

    runApp(
      MyAppProviders(
        appDatabase: database,
        child: const MyApp(),
      )
    );
  }, (error, stack) {
    // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });

}

