
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/features/category/category_page.dart';
import 'package:hadith/features/home/home_page.dart';
import 'package:hadith/features/lists/presentation/show_list/show_list_page.dart';

import '../custom_navigation_bar.dart';

part 'bottom_nav_routers.g.dart';

@TypedShellRoute<BottomBarRouteData>(
  routes: [
    TypedGoRoute<HomeRoute>(
      path: "/home"
    ),
    TypedGoRoute<CategoriesRoute>(
        path: "/categories"
    ),
    TypedGoRoute<ShowListRoute>(
        path: "/show_list"
    ),
  ]
)
class BottomBarRouteData extends ShellRouteData{
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return CustomNavigationBar(child: navigator);
  }
}


class HomeRoute extends GoRouteData{

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: HomePage());
  }
}


class ShowListRoute extends GoRouteData{

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: ShowListPage());
  }
}

class CategoriesRoute extends GoRouteData{

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: CategoryPage());
  }
}

