import 'package:flutter/material.dart';
import 'package:hadith/features/app/navigation/bottom_bar_model.dart';
import '../routes.dart';

class TabNavigator extends StatelessWidget {

  final GlobalKey<NavigatorState>? navigatorKey;
  final BottomBarModel bottomModel;

  const TabNavigator({Key? key,required this.navigatorKey, required this.bottomModel}):super(key: key);


  @override
  Widget build(BuildContext context) {

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {

        if(kRouters.containsKey(routeSettings.name)){
          return MaterialPageRoute(
              settings: RouteSettings(
                  name: routeSettings.name,
                  arguments: routeSettings.arguments
              ),
              builder: (context) => kRouters[routeSettings.name]!.call(context)
          );
        }
        return MaterialPageRoute(
            settings: RouteSettings(
              name: routeSettings.name,
            ),
            builder: (context) => bottomModel.page
        );
      },
    );
  }
}