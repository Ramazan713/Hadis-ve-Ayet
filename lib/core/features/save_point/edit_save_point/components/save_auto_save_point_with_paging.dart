import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_state.dart';
import 'package:hadith/core/presentation/controllers/custom_save_point_position_controller.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';

import 'save_auto_save_point_widget.dart';


class SaveAutoSavePointWithPaging extends StatelessWidget {

  final SavePointDestination destination;
  final SaveAutoType autoType;
  final bool enabled;
  final Widget child;

  final positionController = CustomSavePointPositionController();

  SaveAutoSavePointWithPaging({
    Key? key,
    required this.destination,
    required this.autoType,
    this.enabled = true,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaginationBloc,PaginationState>(
      listenWhen: (prevState, nextState){
        return prevState.visibleMinPos != nextState.visibleMinPos;
      },
      listener: (context, state){
        final pagingItem = state.items.elementAtOrNull(state.visibleMinPos);
        if(pagingItem!=null){
          positionController.setPosition(pagingItem.rowNumber);
        }
      },
      child: SaveAutoSavePointWidget(
        destination: destination,
        autoType: autoType,
        positionController: positionController,
        enabled: enabled,
        key: key,
        child: child,
      ),
    );
  }
}
