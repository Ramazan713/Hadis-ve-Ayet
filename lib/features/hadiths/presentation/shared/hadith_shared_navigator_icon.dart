import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/extensions/app_extension.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_state.dart';
import 'package:hadith/dialogs/show_get_number_bottom_dia.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';

class HadithSharedNavigatorIcon extends StatelessWidget {
  const HadithSharedNavigatorIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final pagingBloc = context.read<PaginationBloc>();

    return BlocBuilder<PaginationBloc, PaginationState>(
      buildWhen: (prevState,nextState){
        return prevState.visibleMinPos != nextState.visibleMinPos;
      },
      builder: (context,state){
        return IconButton(onPressed: (){
          try{
            final item = state.visibleMiddleItem.castOrNull<HadithListModel>();
            if(item == null) return;

            showGetNumberBottomDia(context,(newPos){
              pagingBloc.add(PaginationEventJumpToPos(pos: newPos));
            },currentIndex: item.rowNumber,limitIndex: state.totalItems - 1);

          }catch (e){}

        }, icon: const Icon(Icons.map));
      },
    );
  }
}
