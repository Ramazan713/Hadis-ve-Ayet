import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/app/navigation/bottom_bar_model.dart';
import 'package:hadith/features/app/widget/tab_navigator.dart';
import 'package:hadith/features/premium/bloc/premium_bloc.dart';
import 'package:hadith/features/premium/bloc/premium_event.dart';
import 'bloc/bottom_nav_bloc.dart';
import 'bloc/bottom_nav_state.dart';

class BottomNavBar extends StatefulWidget {
  static const id = "BottomNavBarScreen";
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with WidgetsBindingObserver{
  int _selectedIndex = kBottomPageModels.indexOf(kStartPageModel);

  BottomBarModel _currentModel = kStartPageModel;

  static final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    for(final model in kBottomPageModels) model.keyName: GlobalKey<NavigatorState>(),
  };

  void _selectTab(int index) {
    final model = kBottomPageModels[index];

    if (model == _currentModel) {
      _navigatorKeys[model]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentModel = model;
        _selectedIndex = index;
      });
    }
  }


  Widget getBottomNavWidget(bool isCollapsed) {
    return isCollapsed
        ? const SizedBox.shrink()
        : BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: kBottomPageModels.map((e) =>
                BottomNavigationBarItem(icon: e.icon,label: e.label)).toList(),
            currentIndex: _selectedIndex,
            onTap: (index) {
              _selectTab(index);
            },
          );
  }

  Widget generalBottomView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<BottomNavBloc, BottomNavState>(
          builder: (context, state) {
            final bottomWidget = getBottomNavWidget(state.isCollapsed);

            return state.withAnimation != true ? bottomWidget
                : AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: bottomWidget,
            );
          },
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = await _navigatorKeys[_currentModel.keyName]?.currentState?.maybePop();
        if (isFirstRouteInCurrentTab != null&&!isFirstRouteInCurrentTab) {
          if (_currentModel != kStartPageModel) {
            _selectTab(kBottomPageModels.indexOf(kStartPageModel));
            return false;
          }
          return true;
        }
        return false;
      },
      child: Scaffold(
          bottomNavigationBar: generalBottomView(context),
          body:  TabNavigator(
            navigatorKey: _navigatorKeys[_currentModel.keyName],
            bottomModel: _currentModel,
          )
      ),
    );
  }

  /*

IndexedStack(
            index: _selectedIndex,
            children: kBottomPageModels.map((e) => e.page).toList(),
          ),
    TabNavigator(
            navigatorKey: _navigatorKeys[_currentModel.keyName],
            bottomModel: _currentModel,
          )

   */

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    context.read<PremiumBloc>().add(PremiumEventCheckPurchase());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
