import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/features/app/routes/bottom_nav_routers.dart';


class CustomNavigationBar extends StatelessWidget {
  final Widget child;
  CustomNavigationBar({Key? key, required this.child}) : super(key: key);

  final _navigationItems = [
    _NavigationItem(icon: const Icon(Icons.search), label: "Arama",
        navigationLocation: SearchRoute().location),
    _NavigationItem(icon: const Icon(Icons.home), label: "Ana Sayfa",
        navigationLocation: HomeRoute().location),
    _NavigationItem(icon: const Icon(Icons.dataset), label: "Kategoriler",
        navigationLocation: ExtraFeaturesRoute().location),
    _NavigationItem(icon: const Icon(Icons.view_list), label: "Liste",
        navigationLocation: ShowListRoute().location),
  ];

  List<String> get _navigationLocations  => _navigationItems.map((e) => e.navigationLocation).toList();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: child,
      ),
      bottomNavigationBar: isBottomNavDestination(context) == false ? null :
      BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _calculateIndex(context),
          onTap: (i){
            _onClicked(context,i);
          },
          items: _navigationItems
      ),
    );
  }

  int _calculateIndex(BuildContext context){
    final String location = _currentLocation(context);
    final index = _navigationLocations.indexWhere((element) => location.startsWith(element));
    return max(index, 0);
  }

  bool isBottomNavDestination(BuildContext context){
    final location = _currentLocation(context);
    return _navigationLocations.contains(location);
  }

  String _currentLocation(BuildContext context){
    return GoRouter.of(context).location;
  }

  void _onClicked(BuildContext context,int i){
    context.go(_navigationLocations[i]);
  }
}


class _NavigationItem extends BottomNavigationBarItem{
  final String navigationLocation;

  _NavigationItem({required this.navigationLocation,required Icon icon,required String label}) :
        super(icon: icon,label: label);

}

