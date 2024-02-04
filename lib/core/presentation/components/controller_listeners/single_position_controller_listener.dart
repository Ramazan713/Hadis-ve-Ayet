
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

  @override
  void initState() {
    widget.singlePositionController?.addListener(_listenPosNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _listenPosNotifier(){
    final pos = widget.singlePositionController?.pos;
    if(pos!=null){
      widget.onPosChanged?.call(pos);
    }
  }

  @override
  void dispose() {
    widget.singlePositionController?.removeListener(_listenPosNotifier);
    super.dispose();
  }
}
