import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/constants/enums/theme_enum.dart';
import 'package:hadith/themes/bloc/theme_bloc.dart';
import 'package:hadith/themes/bloc/theme_state.dart';

import '../../themes/dark_theme.dart';
import '../../themes/light_theme.dart';
import '../premium/bloc/premium_bloc.dart';
import '../premium/bloc/premium_event.dart';
import 'routes/combine_routers.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc,ThemeState>(
      builder: (context,state){
        context.read<PremiumBloc>().add(PremiumEventCheckPurchase());

        return Phoenix(
          child: MaterialApp.router(
            routerConfig: _buildRouter,
            title: 'Hadis ve Ayet',
            debugShowCheckedModeBanner: false,
            themeMode: state.themeEnum.mode,
            theme: getLightThemeData(),
            darkTheme: getDarkThemeData(),
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      context.read<PremiumBloc>().add(PremiumEventCheckPurchase());
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
    initialLocation: "/home",
    routes: $combinedAppRoutes
);