import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/bloc/edit_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/bloc/edit_save_point_event.dart';
import 'package:hadith/core/presentation/controllers/custom_save_point_position_controller.dart';

class SaveAutoSavePointWidget extends StatefulWidget{

  final SavePointDestination destination;
  final SaveAutoType autoType;
  final bool enabled;
  final Widget child;
  final CustomSavePointPositionController positionController;

  const SaveAutoSavePointWidget({
    Key? key,
    required this.destination,
    required this.autoType,
    this.enabled = true,
    required this.child,
    required this.positionController
  }) : super(key: key);

  @override
  State<SaveAutoSavePointWidget> createState() => _SaveAutoSavePointWidgetState();
}

class _SaveAutoSavePointWidgetState extends State<SaveAutoSavePointWidget> with WidgetsBindingObserver{
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }


  void _updateSavePoint(){
    if(widget.enabled && K.allowedAutoSavePointTypes.contains(widget.destination.getType())){
      context.read<EditSavePointBloc>()
          .add(EditSavePointEventAutoInsert(
            destination: widget.destination,
            itemIndexPos: widget.positionController.pos,
            autoType: widget.autoType
        )
      );
    }

  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.inactive){
      _updateSavePoint();
    }
  }

  @override
  void deactivate() {
    _updateSavePoint();
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

