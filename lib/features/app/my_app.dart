import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/constants/enums/theme_enum.dart';
import 'package:hadith/core/features/save_point/load_save_point/components/navigate_auto_save_point_wrapper.dart';
import 'package:hadith/features/app/routes/bottom_nav_routers.dart';
import 'package:hadith/features/verses/shared/domain/model/service_audio/background_event.dart';
import 'package:hadith/themes/bloc/theme_bloc.dart';
import 'package:hadith/themes/bloc/theme_state.dart';

import '../../themes/dark_theme.dart';
import '../../themes/light_theme.dart';
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

    final isLight = Theme.of(context).brightness == Brightness.light;
    final statusColor = isLight ? lightColorScheme.primary : darkColorScheme.primary;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: statusColor));

    return BlocBuilder<ThemeBloc,ThemeState>(
      builder: (context,state){
        context.read<PremiumBloc>().add(PremiumEventCheckPurchase());

        return MaterialApp.router(
          routerConfig: _buildRouter,
          title: 'Hadis ve Ayet',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
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