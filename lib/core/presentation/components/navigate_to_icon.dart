import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/dialogs/show_get_number_dia.dart';


class NavigateToIcon extends StatelessWidget {

  final CustomPositionController positionController;
  final void Function(int pos) onPosChanged;
  const NavigateToIcon({Key? key,required this.positionController, required this.onPosChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: positionController,
        builder: (context, child){
          return IconButton(
            onPressed: () {
              showGetNumberDia(
                context,
                listener: (selectedIndex) {
                  onPosChanged(selectedIndex);
                },
                currentIndex: positionController.middleVisiblePos,
                limitIndex: positionController.totalItems - 1,
              );
            },
            icon: const Icon(Icons.map),
            tooltip: "Navigate to position",
          );
        });
  }
}
