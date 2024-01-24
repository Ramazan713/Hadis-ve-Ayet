import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_staggered_grid_view.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/lists/presentation/archive_list/sections/handle_bottom_menu_section.dart';
import 'package:hadith/core/utils/toast_utils.dart';

import '../shared/components/list_item.dart';
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
          child: CustomNestedViewAppBar(
            title: const Text("Arşiv"),
            child: getListItemsContent(),
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
        return LazyStaggeredGridView(
          itemCount: items.length,
          itemBuilder: (context, index){
            final item = items[index];
            final sourceType = item.sourceType;

            return SharedListItem(
              key: Key(item.id.toString()),
              subTitleTag: sourceType.shortName,
              listViewModel: item,
              icon: sourceType.getListIcon(context, item.isRemovable),
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
              onMenuClick: () {
                showAndManageBottomMenu(item, sourceType);
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
