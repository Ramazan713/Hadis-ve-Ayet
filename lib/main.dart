import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hadith/utils/localstorage.dart';
import 'db/instance.dart';
import 'features/app/my_app_providers.dart';
import 'services/foreground_service/foreground_service_helper.dart';


Future<void> main() async {

  runZonedGuarded<Future<void>>(() async {

    WidgetsFlutterBinding.ensureInitialized();

    final database = await getDatabase();

    await LocalStorage.initStorage();
    await Firebase.initializeApp();

    MobileAds.instance.initialize();
    await ForegroundServiceHelper.initializeService();

    // FlutterError.onError =
    //     FirebaseCrashlytics.instance.recordFlutterFatalError;

    runApp(MyAppProviders(
      appDatabase: database,
    ));
  }, (error, stack) {
    // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });

}

