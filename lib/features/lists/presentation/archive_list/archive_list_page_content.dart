import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_aligned_grid_view.dart';
import 'package:hadith/core/features/adaptive/presentation/select_adaptive_dropdown_menu.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_scrollable_app_bar.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/core/presentation/dialogs/show_edit_text_dia.dart';
import 'package:hadith/features/lists/domain/archive_list_menu_enum.dart';
import 'package:hadith/features/lists/presentation/archive_list/bloc/archive_list_bloc.dart';
import 'package:hadith/features/lists/presentation/archive_list/bloc/archive_list_event.dart';
import 'package:hadith/features/lists/presentation/archive_list/bloc/archive_list_state.dart';
import 'package:hadith/features/lists/presentation/shared/components/list_item.dart';
import 'package:hadith/features/lists/presentation/shared/export_list_view.dart';

class ArchiveListPageContent extends StatelessWidget {

  final CustomScrollController scrollController;
  final CustomAutoScrollController contentScrollController;
  final void Function(ListViewModel) onClickItem;
  final bool isSinglePane;

  const ArchiveListPageContent({
    super.key,
    required this.onClickItem,
    required this.isSinglePane,
    required this.scrollController,
    required this.contentScrollController,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultNestedScrollableAppBar(
      scrollController: scrollController,
      contentScrollController: contentScrollController,
      title: const Text("Arşiv"),
      child: BlocBuilder<ArchiveListBloc, ArchiveListState>(
        builder: (context, state) {
          final items = state.listModels;

          if(items.isEmpty){
            return getEmptyWidget(context);
          }
          return LazyAlignedGridView(
            itemCount: items.length,
            padding: K.defaultLazyListPadding,
            controller: contentScrollController.controller,
            itemBuilder: (context, index){
              final item = items[index];
              final sourceType = item.sourceType;
              return SharedListItem(
                key: Key(item.id.toString()),
                subTitleTag: sourceType.shortName,
                listViewModel: item,
                leading: sourceType.getListIcon(context, item.isRemovable),
                isSelected: state.selectedItem?.id == item.id && !isSinglePane,
                trailing: SelectAdaptiveDropdownMenu(
                  popWhenItemSelect: true,
                  icon: const Icon(Icons.more_vert,size: 30,),
                  items: ArchiveListMenuEnum.values,
                  title: "'${item.name}' listesi için",
                  onItemClick: (selected, type){
                    manageBottomMenuItem(
                      context: context,
                      item: item,
                      menuItem: selected,
                      sourceType: sourceType
                    );
                  },
                ),
                onClick: () {
                  onClickItem(item);
                },
              );
            },
          );
        },
      ),
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



extension HandleBottomMenuExt on ArchiveListPageContent{

  void manageBottomMenuItem({
    required BuildContext context,
    required ArchiveListMenuEnum menuItem,
    required SourceTypeEnum sourceType,
    required ListViewModel item
  }){

    switch(menuItem){
      case ArchiveListMenuEnum.rename:
        _rename(context, item);
        break;
      case ArchiveListMenuEnum.remove:
        _remove(context, item);
        break;
      case ArchiveListMenuEnum.unArchive:
        _unArchive(context, item);
        break;
      case ArchiveListMenuEnum.exportAs:
        exportListViewModel(context, item);
        break;
    }
  }

  void _rename(BuildContext context, ListViewModel item){
    final bloc = context.read<ArchiveListBloc>();
    showEditTextDia(context, (newText) {
      bloc.add(ArchiveListEventRename(listViewModel: item, newTitle: newText));
    }, title: "Yeniden İsimlendir", content: item.name);
  }

  void _remove(BuildContext context, ListViewModel item){
    final bloc = context.read<ArchiveListBloc>();
    showCustomAlertDia(
        context,
        title: "Silmek istediğinize emin misiniz?",
        content: "Bu işlem geri alınamaz",
        btnApproved: () {
          bloc.add(ArchiveListEventRemove(listViewModel: item));
        });
  }

  void _unArchive(BuildContext context, ListViewModel item){
    final bloc = context.read<ArchiveListBloc>();
    showCustomAlertDia(
        context,
        title: "Arşivden çıkarmak istediğinize emin misiniz?",
        btnApproved: () {
          bloc.add(ArchiveListEventUnArchive(listViewModel: item));
        });
  }

}