import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/features/theme/bloc/theme_bloc.dart';
import 'package:hadith/core/features/theme/bloc/theme_state.dart';
import 'package:hadith/core/utils/theme_util.dart';
import 'package:hadith/features/app/routes/bottom_nav_routers.dart';
import 'package:hadith/features/verses/shared/domain/model/service_audio/background_event.dart';
import '../premium/bloc/premium_bloc.dart';
import '../premium/bloc/premium_event.dart';
import '../verses/shared/domain/manager/background_verse_audio_manager.dart';
import 'routes/combine_routers.dart';
import 'color_schemes.g.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc,ThemeState>(
      buildWhen: (prevState,nextState){
        return prevState.themeType != nextState.themeType;
      },
      builder: (context,state){
        context.read<PremiumBloc>().add(PremiumEventCheckPurchase());

        ThemeUtil.setStatusBarColor(
          themeEnum: state.themeType,
          brightness: Theme.of(context).brightness
        );

        return MaterialApp.router(
          routerConfig: _buildRouter,
          title: 'Hadis ve Ayet',
          debugShowCheckedModeBanner: false,
          themeMode: state.themeType.mode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme
          ),
        );

        // return Phoenix(
        //   child: MaterialApp(
        //     title: 'Hadis ve Ayet',
        //     debugShowCheckedModeBanner: false,
        //     themeMode: state.themeEnum.mode,
        //     theme: getLightThemeData(),
        //     darkTheme: getDarkThemeData(),
        //     home: const BottomNavBar(),
        //   ),
        // );
      },
    );
  }



  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      context.read<PremiumBloc>().add(PremiumEventCheckPurchase());
      await BackgroundVerseAudioManager.onEvent(BackgroundEventCheckNotificationStatus());
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