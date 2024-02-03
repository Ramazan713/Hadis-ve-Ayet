import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_padding.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_aligned_grid_view.dart';
import 'package:hadith/core/features/adaptive/presentation/select_adaptive_dropdown_menu.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_scrollable_app_bar.dart';
import 'package:hadith/core/utils/toast_utils.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/lists/domain/archive_list_menu_enum.dart';

import '../shared/components/list_item.dart';
import './sections/handle_bottom_menu_section.dart';
import 'bloc/archive_list_bloc.dart';
import 'bloc/archive_list_event.dart';
import 'bloc/archive_list_state.dart';

class ArchiveListPage extends StatefulWidget {
  const ArchiveListPage({Key? key}) : super(key: key);

  @override
  State<ArchiveListPage> createState() => ArchiveListPageState();
}

class ArchiveListPageState extends State<ArchiveListPage> {
  @override
  Widget build(BuildContext context) {
    final listBloc = context.read<ArchiveListBloc>();

    return BlocListener<ArchiveListBloc, ArchiveListState>(
      listener: (context, state) {
        if (state.message != null) {
          ToastUtils.showLongToast(state.message ?? "");
          listBloc.add(ArchiveListEventClearMessage());
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: AdaptivePadding(
            child: DefaultNestedScrollableAppBar(
              title: const Text("Arşiv"),
              child: getListItemsContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget getListItemsContent(){
    return BlocBuilder<ArchiveListBloc, ArchiveListState>(
      builder: (context, state) {
        final items = state.listModels;

        if(items.isEmpty){
          return getEmptyWidget(context);
        }
        return LazyAlignedGridView(
          itemCount: items.length,
          padding: K.defaultLazyListPadding,
          itemBuilder: (context, index){
            final item = items[index];
            final sourceType = item.sourceType;

            return SharedListItem(
              key: Key(item.id.toString()),
              subTitleTag: sourceType.shortName,
              listViewModel: item,
              leading: sourceType.getListIcon(context, item.isRemovable),
              trailing: SelectAdaptiveDropdownMenu(
                popWhenItemSelect: true,
                icon: const Icon(Icons.more_vert,size: 30,),
                items: ArchiveListMenuEnum.values,
                title: "'${item.name}' listesi için",
                onItemClick: (selected, type){
                  manageBottomMenuItem(
                      item: item,
                      menuItem: selected,
                      sourceType: sourceType
                  );
                },
              ),
              onClick: () {
                switch (sourceType) {
                  case SourceTypeEnum.hadith:
                    HadithListRoute(
                        listId: item.id,
                        sourceId: item.sourceType.sourceId
                    ).push(context);
                    break;
                  case SourceTypeEnum.verse:
                    VerseShowListRoute(
                        listId: item.id,
                        sourceId: item.sourceType.sourceId
                    ).push(context);
                    break;
                }
              },
            );
          },
        );
      },
    );
  }

  Widget getEmptyWidget(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.library_add_check_outlined,
              size: 100,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Arşiv'e listeler ekleyebilirsiniz",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
