import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/features/premium/bloc/premium_bloc.dart';
import 'package:hadith/core/features/premium/bloc/premium_event.dart';
import 'package:hadith/core/features/theme/bloc/theme_bloc.dart';
import 'package:hadith/core/features/theme/bloc/theme_state.dart';
import 'package:hadith/core/features/verse_audio/domain/manager/background_verse_audio_manager.dart';
import 'package:hadith/core/features/verse_audio/domain/model/service_audio/background_event.dart';
import 'package:hadith/core/utils/theme_util.dart';
import 'package:hadith/features/app/routes/bottom_nav_routers.dart';
import 'routes/combine_routers.dart';

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    context.read<PremiumBloc>().add(PremiumEventCheckPurchase());
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic){
        return BlocBuilder<ThemeBloc,ThemeState>(
          buildWhen: (prevState,nextState){
            return prevState.themeType != nextState.themeType ||
                prevState.useDynamicColors != nextState.useDynamicColors;
          },
          builder: (context,state){

            final themeSchemes = ThemeUtil.getSchemes(
              themeEnum: state.themeType,
              brightness: Theme.of(context).brightness,
              lightDynamic: lightDynamic,
              darkDynamic: darkDynamic,
              dynamicColorSupported: lightDynamic != null,
              useDynamicColor: state.useDynamicColors
            );

            ThemeUtil.setStatusBarColor(schema: themeSchemes.currentScheme);

            return MaterialApp.router(
              routerConfig: _buildRouter,
              title: 'Hadis ve Ayet',
              debugShowCheckedModeBanner: false,
              themeMode: state.themeType.mode,
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: themeSchemes.lightScheme
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: themeSchemes.darkScheme
              ),
            );
          },
        );
      }
    );


  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      context.read<PremiumBloc>().add(PremiumEventCheckPurchase());
      await BackgroundVerseAudioManager.onEvent(BackgroundEventCheckNotificationStatus(),startIfNotRunning: false);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}


final _buildRouter = GoRouter(
  // navigatorKey: rootNavigatorKey,
    initialLocation: HomeRoute().location,
    routes: $combinedAppRoutes
);