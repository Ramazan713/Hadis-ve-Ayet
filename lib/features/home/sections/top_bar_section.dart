import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/premium/bloc/premium_bloc.dart';
import 'package:hadith/core/features/premium/bloc/premium_state.dart';
import 'package:hadith/core/features/premium/show_premium_active.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_switcher.dart';
import 'package:hadith/core/presentation/components/search/custom_search_bar_empty.dart';
import 'package:hadith/core/presentation/components/selections/dropdown_icon_menu.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/home/enums/home_top_bar_menu_item.dart';
import 'package:hadith/features/home/home_page.dart';

extension HomePageTopBarExt on HomePage{

  List<Widget> getActions(BuildContext context){
    return [
      Expanded(
        child: CustomSearchBarEmpty(
          onTap: (){
            SearchRoute().push(context);
          },
          suffixIcons: _getSuffixActions(context),
        ),
      ),
    ];
  }



  List<Widget> _getSuffixActions(BuildContext context){
    return [
      _getPremiumIcon(),
      CustomDropdownIconMenu(
        items: HomeTopBarMenuItems.values,
        onSelected: (menuItem){
          switch(menuItem){
            case HomeTopBarMenuItems.settings:
              SettingsRoute().push(context);
              break;
          }
        },
      )
    ];
  }

  Widget _getPremiumIcon(){
    return BlocSelector<PremiumBloc, PremiumState, bool>(
      selector: (state) => state.isPremium,
      builder: (context, isPremium){
        return CustomAnimatedSwitcher(
          firstChild: IconButton(
            onPressed: (){
              showPremiumActive(context);
            },
            icon: Icon(
              Icons.workspace_premium,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          secondChild: const SizedBox.shrink(),
          showFirstChild: isPremium,
        );
      },
    );
  }

}