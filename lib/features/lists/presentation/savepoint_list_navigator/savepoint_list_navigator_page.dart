import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/lists/presentation/savepoint_list_navigator/bloc/savepoint_list_navigator_bloc.dart';
import 'package:hadith/features/lists/presentation/savepoint_list_navigator/bloc/savepoint_list_navigator_event.dart';
import 'package:hadith/features/lists/presentation/savepoint_list_navigator/bloc/savepoint_list_navigator_state.dart';

class SavePointListNavigatorPage extends StatelessWidget {
  final int listId;
  final int listDefaultPos;

  const SavePointListNavigatorPage({
    super.key,
    required this.listId,
    required this.listDefaultPos
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SavePointListNavigatorBloc>();

    bloc.add(SavePointListNavigatorEventLoadData(listId: listId));

    return BlocListener<SavePointListNavigatorBloc,SavePointListNavigatorState>(
      listener: (context, state){
        final hasError = state.hasError;
        final navigateToList = state.navigateToList;
        if(hasError){
          bloc.add(SavePointListNavigatorEventClearNavigation());
          context.pop();
        }
        else if(navigateToList != null){
          bloc.add(SavePointListNavigatorEventClearNavigation());
          if(!navigateToList.isArchive){
            ShowListRoute(pos: listDefaultPos,listId: listId, sourceTypeId: navigateToList.sourceType.sourceId)
                .pushReplacement(context);
          }else{
            ArchiveListWithSelectedRoute(pos: listDefaultPos,listId: listId, sourceTypeId: navigateToList.sourceType.sourceId)
                .pushReplacement(context);
          }
        }
      },
      child: const Scaffold(
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
