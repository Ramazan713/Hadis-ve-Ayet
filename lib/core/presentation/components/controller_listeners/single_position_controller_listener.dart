
import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/controllers/custom_sing_position_controller.dart';

class SinglePositionControllerListener extends StatefulWidget {

  final Widget child;
  final CustomSinglePositionController? singlePositionController;
  final void Function(int)? onPosChanged;

  const SinglePositionControllerListener({
    super.key,
    required this.child,
    this.singlePositionController,
    this.onPosChanged
  });

  @override
  State<SinglePositionControllerListener> createState() => _SinglePositionControllerListenerState();
}

class _SinglePositionControllerListenerState extends State<SinglePositionControllerListener> {

  int? currentHashCore;

  @override
  void initState() {
    _addListeners();
    currentHashCore = widget.singlePositionController.hashCode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(currentHashCore != widget.singlePositionController.hashCode){
      currentHashCore = widget.singlePositionController.hashCode;
      _removeListeners();
      _addListeners();
    }
    return widget.child;
  }

  void _listenPosNotifier(){
    final pos = widget.singlePositionController?.pos;
    if(pos!=null){
      widget.onPosChanged?.call(pos);
    }
  }

  void _addListeners() {
    widget.singlePositionController?.addListener(_listenPosNotifier);
  }

  void _removeListeners() async {
    widget.singlePositionController?.removeListener(_listenPosNotifier);
  }

  @override
  void dispose() {
    _removeListeners();
    super.dispose();
  }
}
