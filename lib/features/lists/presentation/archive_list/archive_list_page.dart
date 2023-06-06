import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/save_point/list_book_scope.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/share/share_connect.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/lists/presentation/archive_list/extensions/manage_bottom_menu_item.dart';
import 'package:hadith/features/paging/my_extractor_glow_behavior.dart';
import 'package:hadith/utils/toast_utils.dart';

import '../components/list_item.dart';
import 'bloc/archive_list_bloc.dart';
import 'bloc/archive_list_event.dart';
import 'bloc/archive_list_state.dart';

class ArchiveListPage extends StatelessWidget {
  const ArchiveListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listBloc = context.read<ArchiveListBloc>();

    return ShareConnect(
      child: BlocListener<ArchiveListBloc, ArchiveListState>(
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
                child: BlocBuilder<ArchiveListBloc, ArchiveListState>(
                  builder: (context, state) {
                    final items = state.listModels;

                    if(items.isEmpty){
                      return getEmptyWidget(context);
                    }

                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final sourceType = item.sourceType;

                        return ListItem(
                          subTitleTag: sourceType.shortName,
                          listViewModel: item,
                          icon: sourceType.getListIcon(context, item.isRemovable),
                          onClick: () {
                            switch (sourceType) {
                              case SourceTypeEnum.hadith:
                                HadithListRoute(
                                        listId: item.id,
                                        listBookId: ListBookScopeExt.fromSourceType(item.sourceType).binaryId)
                                    .push(context);
                                break;
                              case SourceTypeEnum.verse:
                                break;
                            }
                          },
                          onMenuClick: () {
                            showAndManageBottomMenu(context, item, sourceType);
                          },
                        );
                      },
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }


  Widget getEmptyWidget(BuildContext context) {
    return Center(
      child: ScrollConfiguration(
        behavior: MyExtractorGlowBehavior(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.library_add_check_outlined,
                size: 150,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Arşiv'e listeler ekleyebilirsiniz",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

}
