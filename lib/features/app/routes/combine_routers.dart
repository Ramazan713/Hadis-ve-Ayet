

import 'package:go_router/go_router.dart';

import 'app_routers.dart' as app_routers;
import 'bottom_nav_routers.dart' as bottom_nav_routers;

List<RouteBase> get $combinedAppRoutes => [
  ...bottom_nav_routers.$appRoutes,
  ...app_routers.$appRoutes
];