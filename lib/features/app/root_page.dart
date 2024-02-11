import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:hadith/core/utils/asset_helper.dart';
import 'package:hadith/features/app/my_app_top_listeners.dart';
import 'package:hadith/features/category/category_page.dart';
import 'package:hadith/features/home/home_page.dart';
import 'package:hadith/features/lists/presentation/show_list/show_list_page.dart';

class RootPage extends StatefulWidget {

  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  var _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {

    return MyAppTopListeners(
      child: AdaptiveScaffold(
        body: (context){
          return SafeArea(
            child: _navigationItems[_selectedIndex].destination,
          );
        },
        destinations: _navigationItems,
        useDrawer: false,
        selectedIndex: _selectedIndex,
        onSelectedIndexChange: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
        leadingExtendedNavRail: getLeadingExtendedNavRail(context),
        leadingUnextendedNavRail: const Spacer(),
        trailingNavRail: const Spacer(),
      ),
    );
  }

  Widget getLeadingExtendedNavRail(BuildContext context){
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                AssetHelper.appImage,
                width: 60,
              ),
              const SizedBox(width: 8,),
              Text(
                "Hadis ve Ayet",
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ],
      ),
    );
  }
}


final _navigationItems = [
  const _NavigationItem(
    icon: Icon(Icons.category_outlined),
    activeIcon: Icon(Icons.category),
    label: "Kategoriler",
    destination: CategoryPage(),
  ),
  const _NavigationItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home),
    label: "Ana Sayfa",
    destination: HomePage(),
  ),
  const _NavigationItem(
    icon: Icon(Icons.view_list_outlined),
    activeIcon: Icon(Icons.view_list),
    label: "Liste",
    destination: ShowListPage(),
  ),
];


class _NavigationItem extends NavigationDestination{
  final Widget destination;
  const _NavigationItem({
    required Icon icon,
    required Icon activeIcon,
    required String label,
    required this.destination
  }) :super(icon: icon,label: label,selectedIcon: activeIcon);

}

