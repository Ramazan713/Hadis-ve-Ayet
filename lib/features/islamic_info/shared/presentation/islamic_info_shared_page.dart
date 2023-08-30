

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/select_font_size/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/dropdown_icon_menu.dart';
import 'package:hadith/features/islamic_info/shared/domain/enums/islamic_info_top_bar_menu_item.dart';
import 'package:hadith/core/domain/enums/islamic_info_type.dart';

import 'bloc/islamic_info_shared_bloc.dart';
import 'bloc/islamic_info_shared_event.dart';
import 'bloc/islamic_info_shared_state.dart';
import 'components/info_collection_item.dart';

class IslamicInfoSharedPage extends StatelessWidget {

  final bool showVertical;
  final String title;
  final IslamicInfoType infoType;

  IslamicInfoSharedPage({
    Key? key,
    required this.infoType,
    required this.title,
    required this.showVertical
  }) : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    context.read<IslamicInfoSharedBloc>()
        .add(IslamicInfoSharedEventLoadData(infoType: infoType));

    return Scaffold(
      body: SafeArea(
        child: CustomNestedViewAppBar(
          title: Text(title),
          actions: getActions(context),
          floating: true,
          snap: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: BlocBuilder<IslamicInfoSharedBloc,IslamicInfoSharedState>(
              builder: (context, state){
                if(state.isLoading){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final items = state.items;

                if(items.isEmpty){
                  return Center(
                    child: Text(
                      "Herhangi bir sonuç bulunamadı",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index){
                    final item = items[index];
                    return InfoCollectionItem(
                      collection: item,
                      showVertical: showVertical,
                      scrollController: scrollController,
                      contentFontSize: state.fontModel.contentFontSize,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }


  List<Widget> getActions(BuildContext context){
    return [
      CustomDropdownIconMenu(
        items: IslamicInfoTopBarMenuItem.values,
        onSelected: (menuItem){
          switch(menuItem){
            case IslamicInfoTopBarMenuItem.fontSize:
              showSelectFontSizeDia(context);
              break;
          }
        },
      )
    ];
  }

}
